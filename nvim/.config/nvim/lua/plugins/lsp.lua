return {
  {
    -- LSP config
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- LSP manager, helps install and manage multiple LSPs
      "williamboman/mason-lspconfig.nvim", -- Extension to integrate mason.nvim better with nvim-lspconfig
      "hrsh7th/cmp-nvim-lsp", -- LSP completion source for nvim-cmp
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason.setup()

      vim.keymap.set("n", "<leader>ll", "<cmd>Mason<CR>", { desc = "Mason LSP manager" })

      mason_lspconfig.setup({
          -- LSPs list for installation
          ensure_installed = {
            "clojure_lsp"
          },

          -- Automatically install missing LSPs based on ensure_installed
          automatic_installation = true,

          -- Specify how to setup specific LSPs (place to put custom configurations)
          handlers = {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function (server_name) -- default handler (optional)
              lspconfig[server_name].setup({
                  capabilities = capabilities
                })
            end,
            -- Next, you can provide a dedicated handler for specific servers.
            -- For example, a handler override for the `rust_analyzer`:
            -- ["rust_analyzer"] = function ()
              --     require("rust-tools").setup {}
            -- end
          }
        })
    end
  },
}
