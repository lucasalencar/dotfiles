return {
  {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Grep files" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find for help (manual)" })
    end
  },
  {
    -- Fuzzy finder
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      vim.keymap.set('n', '<C-p>', '<cmd>Files<CR>', { desc = "Find files" })
    end
  },
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
