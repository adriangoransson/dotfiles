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
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set hidden
set termguicolors
set cursorline

set colorcolumn=+1
set nowrap

set nojoinspaces
set inccommand=split

set mouse+=a

set signcolumn=number

set splitright
set splitbelow

set completeopt=menu,menuone,noselect

set diffopt+=linematch:50

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Search", timeout=300}
augroup END

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ -g\ '!.git/**'
  set grepformat=%f:%l:%c:%m
endif
