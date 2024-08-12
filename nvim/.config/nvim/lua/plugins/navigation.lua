return {
  {
    -- File manager that works like a normal buffer
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(params)
      -- Requires oil.nvim to be setup,
      -- there is a conflict when declaring `opts` and `config`
      require("oil").setup(params._.cache.opts)

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
  {
    -- File tree navigation style
    'nvim-tree/nvim-tree.lua',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeRefresh",
      "NvimTreeFindFile",
    },
    -- TODO Add keymaps not dependent on the plugin load
  },
  {
    -- Vim commands for the bash (:Mkdir, :Move, :Rename, :Copy, :Duplicate, :Delete)
    'tpope/vim-eunuch'
  },
  {
    -- Move and resize vim panels easily (C-e and arrow-letters keys)
    'simeji/winresizer'
  },
}
