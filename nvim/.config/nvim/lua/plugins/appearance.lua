return {
  {
    -- Themes package
    "rafi/awesome-vim-colorschemes",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd('colorscheme molokai')
    end
  },
  {
    -- Status line
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
          lualine_c = { { 'filename', path = 1 } }, -- Filename with relative path
          lualine_x = { 'searchcount', 'filetype' }, -- Keep just filetype removing defaults
      }
    },
  },
  {
    -- Syntax highlighting for multiple languages
    'sheerun/vim-polyglot'
  }
}
