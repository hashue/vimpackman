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

"プラグインをインストール対象に追加
function! vimpackman#add(plugname, ...) abort
  call s:ensure_installed()
  let l:plug = {'name': '', 'url': ''}

  if vimpackman#is_plugname(a:plugname)
    let plug.name = split(a:plugname, '/')[1]
    let plug.url  =
    printf('https://github.com/%s.git',a:plugname)
  endif

  let g:vimpackman#pluglist[l:plug.name] =
  l:plug
endfunction

