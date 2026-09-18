# User Instructions

## Terminology

- "janela" (window) or "painel" (panel) without further context always refers
  to tmux windows or panes, not GUI windows.
- When interacting with tmux panes, prefer the window where this Codex instance
  is running. Only inspect other windows when explicitly requested.

## Atlassian

- For Atlassian tasks, always try the Atlassian MCP first.
- Use the installed and authenticated Atlassian CLI (`acli`) only as a fallback
  when the Atlassian MCP is unavailable, cannot be reached, or an attempted MCP
  operation fails. Perform the same operation through `acli` when falling back.
