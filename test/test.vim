let s:suite = themis#suite('Test for my plugin')
let s:assert = themis#helper('assert')

" owner/repo形式でプラグインが指定されているかをチェック
function s:suite.matchPlugName()
  call s:assert.equals(v:true,vimpackman#is_plugname('hashue/Defie.vim'))
  call s:assert.equals(v:false,vimpackman#is_plugname('/Defie.vim'))
endfunction

