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
  let l:plug = {'name': '', 'url': '', 'stat': 'not_installed'}

  if vimpackman#is_plugname(a:plugname)
    let plug.name = split(a:plugname, '/')[1]
    let plug.url  = printf('https://github.com/%s.git',a:plugname)
  endif

  let g:vimpackman#pluglist[l:plug.name] = l:plug
endfunction

function! vimpackman#update() abort
  call s:ensure_installed()

  "インストール処理
  for l:plugname in keys(g:vimpackman#pluglist)
    let l:plug = g:vimpackman#pluglist[l:plugname]

    echomsg printf("[vimpackman] Install: %s",l:plug.name)

    call system(printf('git clone %s ~/.cache/vimpackman/%s',l:plug.url, l:plug.name))

    if v:shell_error != 0
      echomsg printf("[vimpackman] Install failed: %s",l:plug.url)
    else
      echomsg printf("[vimpackman] Install successed:  %s",l:plug.url)
      let l:plug.stat = 'installed'
    endif
  endfor

  echomsg g:vimpackman#pluglist
  "プラグインが入っているディレクトリをVimが参照できるようにruntimepathに追加
  if isdirectory('~/.cache/vimpackman')
    set rtp+=~/.cache/vimpackman
  endif
endfunction

function! vimpackman#clean() abort
  "todo
endfunction

