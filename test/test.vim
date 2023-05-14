let s:suite = themis#suite('Test for my plugin')
let s:assert = themis#helper('assert')

" owner/repo形式でプラグインが指定されているかをチェック
function s:suite.matchPlugName()
  call s:assert.equals(v:true,vimpackman#is_plugname('hashue/Defie.vim'))
  call s:assert.equals(v:false,vimpackman#is_plugname('/Defie.vim'))
endfunction

"プラグイン情報が追加できるかのテスト function s:suite.addPlugin()
  let l:expect = {'Defie.vim': { 'name': 'Defie.vim', 'url': 'https://github.com/hashue/Defie.vim.git'}}
  call vimpackman#add('hashue/Defie.vim')
  call s:assert.equals(l:expect, g:vimpackman#pluglist)
endfunction
