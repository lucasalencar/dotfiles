// Ambient stub for `@opencode-ai/plugin` used by the plugin adapter.
//
// The real package lives in `~/.config/opencode/node_modules`, which module
// resolution cannot reach from the dotfiles repo path. The plugin only uses
// `Plugin` as a type annotation, so a loose local shape keeps the typecheck
// self-contained. The actual runtime never resolves this module (type-only
// import, executed by the opencode server with Bun).

declare module "@opencode-ai/plugin" {
  export type PluginInput = {
    client: any
    project: any
    directory: string
    worktree: string
    serverUrl: URL
    experimental_workspace: Record<string, unknown>
    $: any
  }

  export type Hooks = {
    event?: (input: { event: any }) => void | Promise<void>
  }

  export type Plugin = (input: PluginInput, options?: unknown) => Promise<Hooks>
}
