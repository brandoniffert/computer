"------------------------------------------------------------------------------
" REPLACE FANCY CHARACTERS
"------------------------------------------------------------------------------
function! bti#fancycharacters#replace()
  let chars = {
        \ "“" : '"',
        \ "”" : '"',
        \ "‘" : "'",
        \ "’" : "'",
        \ "–" : '--',
        \ "—" : '---',
        \ "…" : '...'
        \ }
  exec ":%s/".join(keys(chars), '\|').'/\=chars[submatch(0)]/ge'
endfunction