" Remap leaders
let mapleader = "\<space>"
let maplocalleader = ','

" Navigate over wrapped lines
nnoremap j gj
nnoremap k gk

" Enter command mode
nnoremap <leader><cr> :
vnoremap <leader><cr> :

" Use hjkl for switching between splits
nnoremap <c-h> <c-W>h
nnoremap <c-j> <c-W>j
nnoremap <c-k> <c-W>k
nnoremap <c-l> <c-W>l

" Use arrow keys for tab navigation
nnoremap <left> :tabp<cr>
nnoremap <right> :tabn<cr>

" Select text that was just pasted
nnoremap <leader>gv V`]

" Quick jump back and forth between files
nnoremap <leader><leader> <c-^>

" Quick quit
nnoremap <silent> <leader>q :quit<cr>

" Easy indent/outdent
nnoremap <tab> >>
nnoremap <s-tab> <<
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Make S split lines (opposite of J)
nnoremap <silent> S :<c-u>call bti#functions#BreakHere()<cr>

" Open new horizontal/vertical split
nnoremap <silent> <leader>v :vnew<cr>

" Yank/paste using system clipboard
vnoremap <leader>y "*y
nnoremap <leader>p "*p

" Make Y act like other capital letters
nnoremap Y y$

" Run current file using makeprg
nnoremap <leader>r :make!<cr>

" Cycle line numbering
noremap <silent> <f3> :call bti#functions#CycleLineNumbering()<cr>

" Terminal mode mappings
if exists(':tnoremap')
  tnoremap <leader><esc> <c-\><c-n>
  tnoremap <leader><c-h> <c-\><c-n><c-w>h
  tnoremap <leader><c-j> <c-\><c-n><c-w>j
  tnoremap <leader><c-k> <c-\><c-n><c-w>k
  tnoremap <leader><c-l> <c-\><c-n><c-w>l
endif
