let mapleader="\<Space>"

" Caps + Ö with svorak and xkb ctrl:nocaps
nmap <c-s> :w<cr>

nnoremap <silent><leader><space> :b#<cr>

nnoremap <silent><leader>n :nohlsearch<cr>

" Window management
nnoremap <silent><c-h> <c-w>h
nnoremap <silent><c-j> <c-w>j
nnoremap <silent><c-k> <c-w>k
nnoremap <silent><c-l> <c-w>l

map <silent> [c :cprev<cr>
map <silent> ]c :cnext<cr>

" Exit Terminal mode with 2x Escape.
tnoremap <Esc><Esc> <C-\><C-n>
