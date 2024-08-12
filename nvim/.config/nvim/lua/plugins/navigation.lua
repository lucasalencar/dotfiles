return {
  {
    -- File manager that works like a normal buffer
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(params)
      -- Requires oil.nvim to be setup,
      -- there is a conflict when declaring `opts` and `config`
      require("oil").setup(params._.cache.opts)

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
}
