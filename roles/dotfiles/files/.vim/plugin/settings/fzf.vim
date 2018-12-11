let g:fzf_layout = { 'down': '~30%' }

nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>

if executable('rg')
  nnoremap <leader>a :Rg<space>
endif