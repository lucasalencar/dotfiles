return {
  {
    -- Completion engine that shows code completions popup
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer', -- Adds buffer completion source
      'hrsh7th/cmp-path', -- Adds path completion source
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
          mapping = cmp.mapping.preset.insert({
              ['<C-k>'] = cmp.mapping.select_prev_item(),
              ['<C-j>'] = cmp.mapping.select_next_item(),
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
          -- Sources where completions will be gathered from
          -- Order here matters, they will show up in the menu according to this order
          sources = {
            { name = 'nvim_lsp' }, -- LSP completions
            { name = 'buffer' }, -- text within current buffer
            { name = 'path' }, -- files from system path
          }
        })
    end
  },
  {
    -- Close brackets, quotes, etc. automatically
    'jiangmiao/auto-pairs',
    -- event = 'InsertEnter', -- Commented because it is having issues lazy loading it
  },
  {
    -- Add IA copilot to replace my job
    'github/copilot.vim',
    event = 'InsertEnter',
  },
  {
    -- Surround elements with brackets, quotes, etc.
    'tpope/vim-surround',
  },
  {
    -- Opens repeat command (`.`) to plugins
    'tpope/vim-repeat',
  },
  {
    -- Switch between representations of similar data types (e.g. switch array for a set)
    'AndrewRadev/switch.vim',
  },
}
