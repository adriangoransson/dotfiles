" This will load fzy_native and have it override the default file sorter
lua require('telescope').load_extension('fzy_native')

nnoremap <Leader>p :lua require('telescope.builtin').find_files({ hidden = true })<CR>
nnoremap <Leader>b :Telescope buffers<CR>
