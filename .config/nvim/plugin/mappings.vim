let mapleader="\<Space>"

" <esc> mapped elsewhere, use it.
map <c-c> <nop>
imap <c-c> <nop>

" Caps + Ö with svorak and xkb ctrl:nocaps
nmap <c-s> :w<CR>

nnoremap <silent><Leader><Space> :b#<CR>

nnoremap <silent><Leader>n :nohlsearch<cr>

" Window management
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <silent><leader>j :lua require('trevj').format_at_cursor()<cr>
