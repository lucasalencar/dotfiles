---
name: commit-push
description: Commit (if necessary) and push changes to origin branch
---

## Steps

1. Check logs to see if push is necessary and exit instantly if already
   up-to-date.
2. Check if current branch is main or master and ask if the user wants to create
   a branch before commiting. Suggest a branch name.
3. Check for changes in the current branch and commit them
4. Push changes to origin branch

## Guidelines

- Avoid commiting and pushing every unstaged file. Use the chat context to decide
    which changes the user wants to commit.
- Prefer small, focused commits over large ones. When the working tree contains
    multiple distinct changes, split them into separate commits — one per logical
    unit of work — instead of bundling everything into a single big commit.
- Each commit must be atomic and self-contained: it should represent one coherent
    change, leave the project in a working state (not broken mid-refactor), and
    have a message that clearly explains what that specific change does and why.
- The commit history should read as a sensible progression of atomic steps. If
    you find yourself writing a commit message with "and" joining unrelated
    changes, that's a signal to split it into multiple commits.

## Output instructions

- Check previous commits to decide which language to use on commit
    messages and branch names. Default is English.
