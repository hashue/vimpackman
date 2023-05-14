function! vimpackman#init() abort
  let g:vimpackman#pluglist = {}
endfunction

function! s:ensure_installed() abort
  if !exists('g:vimpackman#pluglist')
    call vimpackman#init()
  endif
endfunction

