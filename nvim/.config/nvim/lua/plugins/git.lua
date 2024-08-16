return {
  {
    -- Git integration
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb' -- Enables GBrowse for Github
    },
    cmd = {
      "G",
      "Git",
      "GBrowse",
    },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
      { "<leader>gd", "<cmd>Gvdiffsplit<CR>", desc = "Git diff" },
      -- Keep using `:` instead of `<cmd>` to avoid breaking visual mode selection
      { "<leader>gb", ":GBrowse<CR>", desc = "Git browse", mode = { "n", "v" } },
      { "<leader>gc", "<cmd>Git commit --verbose<CR>", desc = "Git commit" },
      { "<leader>gP", "<cmd>Git push<CR>", desc = "Git push" },
      { "<leader>gp", "<cmd>Git pull<CR>", desc = "Git pull" },
    }
  },
  {
    -- Shows git changes in the sign column
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

        -- Force Gutter (signs beside the numbers)
        -- colors to always have the same color regardless the colorscheme
        vim.cmd.highlight("GitSignsAdd guifg=green")
        vim.cmd.highlight("GitSignsChange guifg=yellow")
        vim.cmd.highlight("GitSignsDelete guifg=red")

        vim.cmd.highlight("GitSignsStagedAdd guifg=darkgreen")
        vim.cmd.highlight("GitSignsStagedChange guifg=darkyellow")
        vim.cmd.highlight("GitSignsStagedDelete guifg=darkred")
      end

    },
  },
  {
    -- Git rich interface inside editor
    'kdheepak/lazygit.nvim',
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
    cmd = {
      "LazyGit",
    }
  }
}
