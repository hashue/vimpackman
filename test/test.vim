let s:suite = themis#suite('Test for my plugin')
let s:assert = themis#helper('assert')

" owner/repo形式でプラグインが指定されているかをチェック
function s:suite.matchPlugName()
  call s:assert.equals(v:true,vimpackman#is_plugname('hashue/Defie.vim'))
  call s:assert.equals(v:false,vimpackman#is_plugname('/Defie.vim'))

"プラグイン初期化関数のテスト
function s:suite.initVimpackman()
  let l:path = '/tmp/vimpackman'
  call vimpackman#init(l:path)
  call s:assert.equals(v:true, exists('g:vimpackman#pluglist'))
  call s:assert.equals(v:true, isdirectory(l:path))
  call system('rm -rf /tmp/vimpackman')
endfunction

"プラグイン情報が追加できるかのテスト
function s:suite.addPlugin()
  let l:expect = {
        \  'Defie.vim': {
        \    'name': 'Defie.vim',
        \    'url': 'https://github.com/hashue/Defie.vim.git',
        \    'stat': 'not_installed'
        \  }
        \}
  call vimpackman#add('hashue/Defie.vim')
  call s:assert.equals(l:expect, g:vimpackman#pluglist)
endfunction

"プラグインがインストールできるかのテスト
function s:suite.installPlugin()
  call vimpackman#init('/tmp/vimpackman')
  call vimpackman#add('hashue/Defie.vim')
  call vimpackman#update()
  call s:assert.equals(1, isdirectory('/tmp/vimpackman/Defie.vim'))
endfunction

"プラグインが削除できるかのテスト
function s:suite.removePlugin()
  call vimpackman#init('/tmp/vimpackman')
  call vimpackman#add('vim-denops/denops.vim')
  call vimpackman#add('hashue/Defie.vim')
  call vimpackman#init('/tmp/vimpackman')
  call vimpackman#add('hashue/Defie.vim')
  call vimpackman#update()
  call s:assert.equals(1, !isdirectory('/tmp/vimpackman/denops.vim'))
endfunction
