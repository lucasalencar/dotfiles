return {
  {
    -- LSP config
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- LSP manager, helps install and manage multiple LSPs
      "williamboman/mason-lspconfig.nvim" -- Extension to integrate mason.nvim better with nvim-lspconfig
    },
    config = function()
      require("mason").setup()

      vim.keymap.set("n", "<leader>ll", "<cmd>Mason<CR>", { desc = "Mason LSP manager" })

      require("mason-lspconfig").setup({
          -- LSPs list for installation
          ensure_installed = {
            "clojure_lsp"
          },

          -- Automatically install missing LSPs based on ensure_installed
          automatic_installation = true,
        })


      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
          --     require("rust-tools").setup {}
        -- end
      }
    end
  },
}
