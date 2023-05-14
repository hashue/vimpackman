function! vimpackman#init() abort
  let g:vimpackman#pluglist = {}
endfunction

function! s:ensure_installed() abort
  if !exists('g:vimpackman#pluglist')
    call vimpackman#init()
  endif
endfunction

function! vimpackman#is_plugname(plugname) abort
  if a:plugname =~? '^[-._0-9a-z]\+\/[-._0-9a-z]\+$'
    return v:true
  else
    return v:false
  endif
endfunction

