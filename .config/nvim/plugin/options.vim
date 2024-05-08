" (Neo)vim options.

set number
set relativenumber

set ignorecase
set smartcase

set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=10

set undofile
set noswapfile

set list
set listchars=tab:➝\ ,trail:·,multispace:·,extends:>,precedes:<,nbsp:+
set hidden
set termguicolors
set cursorline

set colorcolumn=+1
set nowrap

set nojoinspaces

set mouse+=a

set signcolumn=number

set splitright
set splitbelow

set completeopt=menu,menuone,noselect

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ -g\ '!.git/**'
  set grepformat=%f:%l:%c:%m
endif
