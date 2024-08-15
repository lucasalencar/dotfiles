return {
  {
    -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'} -- Better performance
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Grep files" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find for help (manual)" })

      local actions = require("telescope.actions")
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        }
      }
    end
  },
  {
    -- Fuzzy finder
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    enabled = false,
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
    'tpope/vim-eunuch',
    cmd = {
      "Mkdir",
      "Move",
      "Rename",
      "Copy",
      "Duplicate",
      "Delete",
    },
  },
  {
    -- Move and resize vim panels easily (C-e and arrow-letters keys)
    'simeji/winresizer',
    keys = {
      { "<C-e>", "<cmd>WinResizerStartResize<CR>", desc = "Start window resizer" },
    }
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  }
}
