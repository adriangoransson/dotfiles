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

nnoremap <silent><leader>p :Telescope find_files<cr>
nnoremap <silent><leader>b :Telescope buffers<cr>

nnoremap <silent><leader>j :lua require('trevj').format_at_cursor()<cr>

map <silent> [c :cprev<cr>
map <silent> ]c :cnext<cr>
