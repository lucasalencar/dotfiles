return {
  {
    "rafi/awesome-vim-colorschemes",
    config = function()
      vim.cmd('colorscheme molokai')
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
          lualine_c = { { 'filename', path = 1 } }, -- Filename with relative path
          lualine_x = { 'searchcount', 'filetype' }, -- Keep just filetype removing defaults
      }
    },
  }
}
