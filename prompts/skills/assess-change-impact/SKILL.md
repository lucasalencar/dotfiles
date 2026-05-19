---
name: assess-change-impact
description: Analyze a code change for non-obvious ripple effects across the rest of the system. Use after AI-generated edits, before merge, to surface semantic shifts, symmetric code paths, test fixture antipatterns, and latent bugs hidden behind a change that looks local. Language- and project-agnostic. Trigger when the user asks for "impact analysis", "what else could break", "did this change anything else", "review the blast radius of these changes", or wants a pre-merge safety check on AI-generated edits.
---

## When to use

After a non-trivial code change has been made on the current branch (typically by AI), and before the change is merged or rolled out. Use as a pre-merge gate even when tests pass — the change may have shifted semantics in ways the tests do not cover.

**Use for:** parsers/serializers, shared utilities, discriminator handling, error paths, public APIs, anything called from multiple sites, anything touching wire formats or persisted data.

**Skip for:** typo fixes in dead code, single-line config tweaks with obvious scope, changes confined to a single private function with one caller.

## Inputs

- The diff to be analyzed. Default: `git diff <merge-base>..HEAD`. If the user gave a PR URL, use that PR's diff.
- The codebase the change lives in. Use the project's search tools (`grep`/`rg`/IDE search) to verify claims — do not speculate about callsites or fixture origins.

## Methodology

Run each step explicitly. Do not skip — gaps here are how non-obvious bugs survive.

### 1. Enumerate the semantic changes

For each file in the diff, write down what changed in terms of **semantics**, not lines:

- New conditions accepted or rejected
- New exceptions raised or swallowed
- New side effects (logs, metrics, I/O, network)
- Field/argument additions, removals, or type changes
- Renamed symbols (functions, types, constants, strings used as keys/discriminators)
- Behavior changes inside shared helpers

"Refactor with no behavior change" is a hypothesis. Verify it.

### 2. For every changed symbol, find every callsite

Use the project's search tools. For each callsite, ask:

- Does the caller depend on the OLD behavior in a way the change breaks?
- Does the caller now exercise a code path that did not exist before?

Include: imports, string references (when the symbol is a route, event name, key), serialized representations (DB columns, API payloads, message queue formats), tests, fixtures, snapshot data, mock servers, documentation, monitoring queries.

If a symbol is exported, check downstream packages/services that may consume it.

### 3. Inventory "what newly matches" vs "what stopped matching"

For any change that touches dispatching (pattern matches, if/elif chains, lookup tables, regexes, type unions, routing rules, switch statements):

- List every input shape that was accepted before but now is NOT (loss of coverage)
- List every input shape that is NOW accepted but was not before (new coverage)
- For each, ask: is there real-world data that lands in that set?

This catches "we fixed a typo in a case clause, but the typo was load-bearing in production data" bugs.

### 4. Check symmetric and sibling code paths

If the change is on one side of a data flow (e.g., parsing inbound payloads), check the matching code on the other side (e.g., constructing outbound payloads). Look for:

- Input parser vs output builder for the same data shape — do they now disagree?
- Sibling handlers/adapters with the same structure as the one changed — do they have the same latent bug the change just fixed?

Asymmetries between input and output of the same data structure are often invisible until production.

### 5. Check test fixtures and snapshots

A test fixture built by copy-pasting from the production code under test is **load-bearing**, not authoritative. When the production code changes, the fixture moves with it and the test keeps passing without verifying anything.

For every test that exercises the changed code:

- Where do the fixture values come from? Upstream schema? Real captured sample? Or copied from the parser/serializer being tested?
- If from the code under test: flag as risky — the same bug can hide on both sides.
- For snapshot/golden files: same question. Was the snapshot re-validated against an authoritative source recently, or has it been ratcheting whatever the code outputs?

### 6. Check production-vs-test code paths

- Are there feature flags or config gates that change which code path runs?
- Do tests exercise the same gate state as production? (Default-off feature being tested only as default-on is a common gap.)
- Are there environment-specific code paths (dev/staging/prod, region, tenant) that may behave differently from the path the tests cover?

### 7. Verify preserved invariants

Explicitly state what should NOT have changed and verify each by reading the new code:

- Public API signatures
- Wire formats / serialized shapes
- Error contracts (which exceptions a caller can see, error codes)
- Performance characteristics (an O(n) operation should not have become O(n²))
- Thread-safety / concurrency guarantees
- Resource lifecycle (handles closed, transactions committed, locks released)

### 8. Check cross-cutting concerns

These are easy to forget because the diff often does not touch them directly:

- **Logging**: log volume/level changes; sensitive data now logged
- **Metrics**: any counter/histogram that now misses events or double-counts
- **Database**: schema/migration safety, transaction boundaries, lock scope
- **Security**: input validation, deserialization safety, authz/authn flow
- **Performance**: new allocations, sync I/O on hot paths, N+1 patterns
- **Backward compatibility**: rolling deploys, old clients hitting new servers and vice versa, persisted data written by old code being read by new code

### 9. Identify what is out of scope but related

A change often reveals a category of bugs (e.g., "this discriminator mismatch", "this missing null check", "this off-by-one") that exists in sibling code paths the diff does not touch. Note these as follow-ups — do not expand the PR to fix them, but record them so they are not lost.

## Output

Report findings in this structure. Empty sections are fine — write "none found" rather than deleting them, so the reader knows the step was performed.

### ✅ Confirmed clean

What was checked and came back safe. Be specific: "No remaining callers of the old symbol anywhere in the repo (searched: <pattern>)."

### ⚠️ Medium-severity risks

Things that warrant a closer look or a follow-up. For each: what the risk is, where it lives (file/symbol), suggested action.

### 🟡 Low-severity / hygiene

Not bugs, but reduce future maintainability or hide other bugs (stale names, duplicated fixtures, missing warnings, etc.).

### 🟢 Preserved invariants

Explicit confirmation that key invariants (API signatures, wire formats, error contracts, performance, concurrency) still hold.

### Suggested follow-ups

Ranked by ROI. Distinguish "block this PR" from "open a follow-up ticket".

## Output rules

- Cite specific files, lines, or symbols. Vague findings ("might affect callers") are noise — verify or drop.
- Order findings by blast radius, not by where they appear in the diff.
- If you cannot verify something by reading the code, say so explicitly — do not assert.
- Match the language used by the user; default English.
- Keep the report tight. A reviewer should be able to act on each finding in under a minute.
