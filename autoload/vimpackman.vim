function! vimpackman#init(path = '~/.cache/vimpackman') abort
  let g:vimpackman#pluglist = {}
  let s:base_path = expand(a:path)
  if !isdirectory(s:base_path)
    call mkdir(s:base_path)
  endif
  set rtp+=s:base_path
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
    let l:dir  = s:base_path . '/' . l:plug.name

    "ディレクトリが存在する = インストール済みなのでスキップする
    if isdirectory(expand(l:dir))
      echomsg printf("[vimpackman] Update: %s",l:plug.name)
      let l:res  = system(printf('git -C %s pull ', l:dir))
    else
      echomsg printf("[vimpackman] Install: %s",l:plug.name)
      let l:res  = system(printf('git clone %s %s',l:plug.url, l:dir))
      let l:plug.stat = 'installed'
    endif

    let l:stat = (v:shell_error == 0)? 'successed': 'failed'
    echomsg printf("[vimpackman] Install %s: %s", l:stat, l:res)
  endfor

endfunction

function! vimpackman#clean() abort
  "todo
endfunction

