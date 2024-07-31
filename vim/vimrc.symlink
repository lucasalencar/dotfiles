" Install vim-plug in case it is not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" load vim-plug
call plug#begin('~/.vim/plugged')

" Plugin with default configurations agreed with the community
" This is good to make the configurations in this file simpler
Plug 'tpope/vim-sensible'

""" APPEARANCE PLUGINS
Plug 'itchyny/lightline.vim' " Minimalist status line
Plug 'ap/vim-css-color' " Show color when writing HEX colors
Plug 'sheerun/vim-polyglot' " Syntax highlight for many languages
Plug 'rafi/awesome-vim-colorschemes'

if has('nvim')
  Plug 'nvim-tree/nvim-web-devicons'
endif
""" end APPEARANCE PLUGINS

""" TEXT MANIPULATION PLUGINS
Plug 'scrooloose/nerdcommenter' " Plugin to add comments according to language
Plug 'tpope/vim-surround' " Easily add things surrounding selections
Plug 'tpope/vim-unimpaired' " https://github.com/tpope/vim-unimpaired/blob/master/doc/unimpaired.txt
Plug 'tpope/vim-repeat' " Repeat commands from plugins with .
Plug 'junegunn/vim-easy-align' " Align tables in text easily
Plug 'bronson/vim-trailing-whitespace' " Remove trailing whitespace
Plug 'tmhedberg/matchit' " Matches HTML tags with %
Plug 'AndrewRadev/switch.vim' " Switch a representation by another (ex: string to symbol in ruby)
""" end TEXT MANIPULATION PLUGINS

""" NAVIGATION PLUGINS
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  } | Plug 'junegunn/fzf.vim' " File fuzzy search and content search
Plug 'preservim/nerdtree', { 'on': 'NERDTreeFind' } " File tree
Plug 'thinca/vim-visualstar' " Search for terms using * or # on Visual Mode
Plug 'simeji/winresizer' " Move and resize vim panels easily (C-e and arrow-letters keys)
Plug 'tpope/vim-eunuch' " Vim commands for the bash (Mkdir, Move, Rename, ...)

if has('nvim')
  Plug 'stevearc/oil.nvim' " File manager that works like a normal buffer
endif
""" end NAVIGATION PLUGINS

""" TMUX PLUGINS
" OBS: Creates panel switching mapping using ctrl+<direction>
" It is not necessary to add it to vimrc
Plug 'christoomey/vim-tmux-navigator'

" When losing or gaining focus, execute some autocommands
" Fixes some behaviors when using vim inside tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
""" end TMUX PLUGINS

""" GENERAL LANG TOOLING
Plug 'ervandew/supertab' " Complete what is being written with <tab>
"Plug 'w0rp/ale' " Linters
Plug 'github/copilot.vim' " Add IA copilot to replace my job
Plug 'jiangmiao/auto-pairs' " When opening parenthesis it closes automatically

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
endif
""" end GENERAL LANG TOOLING


""" GIT PLUGINS
Plug 'tpope/vim-fugitive' " Git wrapper for vim
Plug 'tpope/vim-rhubarb' " Git extension for vim-fugitive
Plug 'airblade/vim-gitgutter' " Git add or removed lines indication

if has('nvim')
  Plug 'kdheepak/lazygit.nvim'
endif
""" end GIT PLUGINS

""" MARKDOWN PLUGINS
" If you have nodejs
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
""" end MARKDOWN PLUGINS

""" RUBY & RAILS PLUGINS
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'sunaku/vim-ruby-minitest', { 'for': 'ruby' } " Syntax highlight
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " Add end when opening block in ruby
Plug 'AndrewRadev/splitjoin.vim', { 'for': 'ruby' } " Split inline constructs to multiple lines and vice versa
""" end RUBY & RAILS PLUGINS

""" CLOJURE PLUGINS
" Clojure nREPL integration
Plug 'Olical/conjure', { 'for': 'clojure' }

""" Support to lein projects
" - Adds navigation to specific dirs (:Esource :Etest)
" - Allow open alternativa files (:A :AT :AV)
" - Allow to open a REPL through vim (:Console)
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist' " Allows to map projections to the project (dependency to vim-salve)

" Static syntax highlight for clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
" Turns syntax highlight dynamic, allows to highlight project defined functions
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }

Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'luochen1990/rainbow', { 'for': 'clojure' } " Rainbow parenthesis

if has('nvim')
  Plug 'snoe/clj-refactor.nvim', { 'for': 'clojure' } " Nice keybindings to refactor clojure code
endif
""" end CLOJURE PLUGINS

call plug#end()

" Load any config related to editor appearance
source $DOTFILES_ROOT/vim/appearance.vim

" Load sensible configs for vim
source $DOTFILES_ROOT/vim/sensible.vim

" Load all my custom mappings
source $DOTFILES_ROOT/vim/mappings.vim
source $DOTFILES_ROOT/vim/git.vim
source $DOTFILES_ROOT/vim/markdown.vim

" Load all maps that use MacOS option-key unicode characters
"source $DOTFILES_ROOT/vim/mac-option-maps.vim

" Load all alt-key maps
" Use this when macos_option_as_alt for kitty is set to yes
source $DOTFILES_ROOT/vim/alt-maps.vim

" Load python configurations (nvim uses python in some plugins)
source $DOTFILES_ROOT/vim/python.vim

source $DOTFILES_ROOT/vim/easyalign.vim
source $DOTFILES_ROOT/vim/fzf.vim
source $DOTFILES_ROOT/vim/nerdtree.vim
source $DOTFILES_ROOT/vim/vim-tmux-navigator.vim
source $DOTFILES_ROOT/vim/clojure.vim
source $DOTFILES_ROOT/vim/vim-sexp.vim
source $DOTFILES_ROOT/vim/coc.vim

" Hack to run Lua inside vimscript
" Maintain identation like this to avoid problems
lua <<EOF
-- Load oil.nvim and set keymap
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
EOF
