set nocompatible

filetype plugin indent on
syntax on

set autoindent
set backspace=indent,eol,start
set display+=lastline

set wildmenu
set ruler
set smarttab

set number
set relativenumber

set laststatus=2
set incsearch
set hlsearch
set smartcase

set nrformats-=octal
set tabstop=4
set shiftwidth=4
set expandtab

set autoread

set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Caps + Ö with svorak and xkb ctrl:nocaps
inoremap <C-s> <esc>

call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-sleuth'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
call plug#end()
