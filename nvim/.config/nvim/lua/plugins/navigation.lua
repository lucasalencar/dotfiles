return {
  {
    -- File manager that works like a normal buffer
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = {
        show_hidden = true,
      }
    },
    keys = {
      { "-", "<CMD>Oil<CR>", desc = "Open parent directory" }
    },
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
    keys = {
      { "<leader>t", "<cmd>NvimTreeFindFile<cr>", desc = "Nvim Tree Find File" },
    },
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
