" Tabbar在左侧显示
let g:tagbar_left=1

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=0

"let g:pydiction_location = g:_vimfiles."/bundle/Pydiction/complete-dict"
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

autocmd FileType php setlocal let b:surround_112 = "<?php \n ?>"

"let g:AutoPairsMapCR = 0
