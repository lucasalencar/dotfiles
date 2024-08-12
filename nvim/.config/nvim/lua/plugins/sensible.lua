return {
  -- Plugin with default configurations agreed with the community
  -- This is good to make the configurations in this file simpler
  "tpope/vim-sensible",

  -- Some general sensible defaults not really related to the plugin
  config = function()
    vim.o.number = true -- Show line numbers
    vim.o.cursorline = true -- Highlights current line
    vim.o.colorcolumn = "100" -- Highlights column 100 to avoid passing this line size
    vim.o.clipboard = "unnamed" -- Makes clipboard work with the one used by macos
    vim.o.mouse = "a" -- Enables mouse actions on all modes (Insert, Normal, Visual, Command, etc)
    vim.o.showmode = false -- Do not show --INSERT-- when on insert mode (or any other mode indication)
    vim.o.autoread = true -- Autoreads the file from disk when it is changed outside vim
    vim.o.lazyredraw = true -- Config for faster buffer scrolls
    vim.o.wrap = false -- Do not wraps words when it reaches borders

    -- Persistent undo
    vim.o.undofile = true -- Maintain undo history through sessions
    vim.o.undodir = vim.fn.expand('~/.vim/undodir') -- Sets dir to store undo history

    -- Backup and swap files
    -- `//` means that vim is allowed to create subdirectories
    vim.o.backupdir = vim.fn.expand('~/.vim/_backup//') -- Directory for backup files
    vim.o.directory = vim.fn.expand('~/.vim/_temp//') -- Directory for swap files

    -- Whitespace
    vim.o.tabstop = 2 -- A tab is two spaces
    vim.o.shiftwidth = 2 -- An autoindent (with <<) is two spaces
    vim.o.expandtab = true -- Use spaces, not tabs

    vim.o.list = true -- Show invisible characters
    -- List chars:
    -- tab prints "  " (2 spaces) for tabs
  -- trail prints "." for empty spaces at the end of the line
  -- When wrap is off:
  --    extends prints ">" in the last column when the line continues beyond the right of the screen
  --    precedes prints "<" in the last column when the line continues beyond the left of the screen
  vim.o.listchars = 'tab:  ,trail:.,extends:>,precedes:<'

  -- Strip whitespace on save
  vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      command = [[%s/\s\+$//e]],
    })

  -- Searching
  vim.o.hlsearch = true -- Highlight matches
  vim.o.ignorecase = true -- Searches are NOT case sensitive
  vim.o.smartcase = true -- Unless they contain at least one capital letter

  -- Wildignore: ignoring files when using wildmenu for searching files
  vim.o.wildignore = '*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,' .. -- Disable output and Version Control files
  '*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,' .. -- Compression files
  '*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,' .. -- Bundler and Sass files
  '*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*,' .. -- Librarian-Chef, Vagrant, Test-Kitchen e Berkshelf.
  '*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*,' .. -- Rails temporary asset caches
  '*.swp,*~,._*' -- Temp and Backup files from vim

  -- Auto save all files on window focus lost
  vim.api.nvim_create_autocmd('FocusLost', {
      pattern = '*',
      callback = function()
        if vim.fn.getbufvar(vim.fn.bufnr(), '&modified') == 1 then
          vim.cmd('silent! wa')
        end
      end,
    })
end
}
