# User Instructions

## Output

- When reporting information to me, be extremely concise and sacrifice grammar for the sake of concision.

## Terminology

- "janela" (window) or "painel" (panel) without further context always refers to tmux windows/panes, not GUI windows.
- When interacting with tmux panes, prefer the window where this Claude instance is running. Only look at other windows when explicitly told to.

## Atlassian

- For Atlassian tasks, always try the Atlassian MCP first.
- Use the installed and authenticated Atlassian CLI (`acli`) only as a fallback
  when the Atlassian MCP is unavailable, cannot be reached, or an attempted MCP
  operation fails. Perform the same operation through `acli` when falling back.

## Worktrees

- When dealing with git worktrees, use the Worktrunk skills instead of raw `git worktree` commands.
