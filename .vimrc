"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"light13's vim config
"2010/12/16 21:56:07
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim:set shiftwidth=2:

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"General Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible   "与vi不兼容
set history=1024     "历史记录最高数目
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype indent on           " 启用自动补全
set autoread       "文件更新时重新读取
set mouse=a  "所有模式下都可以用鼠标
set selectmode=mouse,key "鼠标和shift加特殊键选区算选择模式，不是可视模式
set nobackup   "取消自动备份
set backupext=.bak   "自动备份文件后缀
set autochdir " 设定文件浏览器目录为当前目录
set foldmethod=manual        " 选择代码折叠类型
set nopaste "粘贴时保留原有格式 --> 关闭了，不然autoclose不能自动补全括号
set wildignore=*.o,*~,*.pyc  "打开文件、补全文件等时忽略提示这些后缀的文件
set tags=./tags;/,tags,./**/tags "查找tags文件

if has("win32")
  let g:_vimfiles = $VIM."/vimfiles"
  let g:_vimrc = $VIM."/_vimrc"
else
  let g:_vimfiles = "~/.vim"
  let g:_vimrc = "~/.vimrc"
endif

""windows上如果装了cygwin，设置shell为mintty
"if has("win32")
"  if filereadable("D:/cygwin/bin/mintty.exe")
"    set shell=D:/cygwin/bin/mintty.exe
"    set shellcmdflag=-i\ /Cygwin-Terminal.ico\ -
"  endif
"endif

"记录上次打开文件位置
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%

  """"""""""""""""""""""""""""""
  " => Shortcuts
  """"""""""""""""""""""""""""""
  "快捷键
  let mapleader = ","
  let g:mapleader = ","

  "编辑配置文件
  map <leader>e :exec "e ".expand(g:_vimrc)<cr>
  "另一种在命令模式下展开变量的方法
  "map <leader>e :e <c-r>=expand(g:_vimrc)<cr><cr>
  "更新配置
  map <leader>u :exec "source ".expand(g:_vimrc)<cr>
  autocmd! bufwritepost g:_vimrc source g:_vimrc "修改配置文件后更新

  "上下移动行
  nmap <M-j> mz:m+<cr>`z
  nmap <M-k> mz:m-2<cr>`z
  vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
  vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

  "buffer相关
  map <leader>bd :bd!<cr>

  "取消高亮
  nmap <leader>hl :nohlsearch<cr>
  "刷新屏幕
  nmap <leader>l <C-L>
  "修改文件换行方式
  nmap <leader>fd :set ff=dos<cr>
  nmap <leader>fu :set ff=unix<cr>
  nmap <leader>fm :set ff=mac<cr>

  "语法识别
  map <leader>c :set syntax=c<cr>
  map <leader>cpp :set syntax=cpp<cr>
  map <leader>py :set syntax=py<cr>
  map <leader>java :set syntax=java<cr>
  map <leader>pas :set syntax=pascal<cr>
  map <leader>vim :set syntax=vim<cr>
  autocmd BufEnter * :syntax sync fromstart

  "行回绕时移动比较符合直觉
  nmap j gj
  nmap k gk

  "有多个窗口时方便移动
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l
  map <C-UP> <C-W>-
  map <C-DOWN> <C-W>+
  map <C-LEFT> <C-W><
  map <C-RIGHT> <C-W>>

  "输入模式下方便操作
  imap <c-h> <ESC>I  "将光标移到行首
  imap <c-j> <ESC>jI "将光标移到下一行的行首
  imap <c-k> <ESC>kA "将光标移到上一行的末尾
  imap <c-l> <ESC>A  "将光标移到行尾

  "保存文件
  map <c-s> <ESC>:w<CR>
  imap <c-s> <ESC>:w<CR>a
  vmap <c-s> <ESC>:w<CR>
  nmap <leader>s :w!<cr>

  "标签页
  map <leader>tn :tabnew %<cr>
  map <leader>tc :tabclose<cr>
  map <leader>te :tabedit<cr>
  nmap <C-tab> gt
  nmap <C-S-tab> gT

  "空格翻页比较符合习惯
  map <space> <C-D>

  "在可视模式下按<leader>再按*或＃可以对选中的部分进行搜索
  vnoremap <silent> * :call VisualSearch('f')<CR>
  vnoremap <silent> # :call VisualSearch('b')<CR>

  "设置tab宽度
  map <leader>t2 :set shiftwidth=2<cr>
  map <leader>t4 :set shiftwidth=4<cr>
  map <leader>t8 :set shiftwidth=8<cr>

  "快速签名
  iab xdatetime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
  iab xtime <c-r>=strftime("%H:%M:%S")<cr>
  iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
  iab xname light13

  "vimgrep递归搜索
  map <leader>ga :vimgrep // **/*<left><left><left><left><left><left>
  "vimgrep 搜索当前文件
  map <leader>gg :vimgrep // <C-R>%<home><right><right><right><right><right><right><right><right><right>

  " 一步加载语法模板和作者、时间信息 [非插入模式]
  map <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
  vmap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi

  "打开NERDTree [非插入模式]
  map <leader>nt :NERDTree<CR>
  " 打开Taglist [非插入模式]
  map <leader>tl :Tlist<CR>
  " 打开Tagbar [非插入模式]
  map <leader>tb :TagbarToggle<CR>
  " 选择tag
  map <leader>ts :tselect<CR>
  " 打开Gundo [非插入模式]
  map <leader>gu :GundoToggle<CR>

  "成对符号匹配
  "inoremap ( <c-r>=OpenPair('(')<CR>
  "inoremap ) <c-r>=ClosePair(')')<CR>
  "inoremap [ <c-r>=OpenPair('[')<CR>
  "inoremap ] <c-r>=ClosePair(']')<CR>
  "inoremap { <c-r>=OpenPair('{')<CR>
  "inoremap } <c-r>=ClosePair('}')<CR>
  "inoremap ' <c-r>=CompleteQuote("'")<CR>
  "inoremap " <c-r>=CompleteQuote('"')<CR>

  "可视模式下加各种括号和引号
  vnoremap ( <esc>`>a)<esc>`<i(<esc>
  vnoremap [ <esc>`>a]<esc>`<i[<esc>
  vnoremap { <esc>`>a}<esc>`<i{<esc>
  "vnoremap < <esc>`>a><esc>`<i<<esc> "影响到缩进了
  vnoremap ' <esc>`>a'<esc>`<i'<esc>
  "vnoremap " <esc>`>a"<esc>`<i"<esc> "影响到复制了

  "缩进快捷键
  nmap <tab> V>
  nmap <S-tab> V<
  vmap <tab> >gv
  vmap <S-tab> <gv
  vmap > >gv
  vmap < <gv

  "在命令模式下也能用Bash快捷键
  cmap <C-a> <HOME>
  cmap <C-e> <END>
  cnoremap <C-b> <LEFT>
  cnoremap <C-f> <RIGHT>
  cnoremap <C-p> <UP>
  cnoremap <C-n> <DOWN>
  cnoremap <C-d> <DEL>

  "vimwiki转成html快捷键
  map <Leader>wh :Vimwiki2HTML<CR>
  map <Leader>wah :VimwikiAll2HTML<CR>

  "windows全屏
  if has('win32')
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
  endif

  " Ctrl + C 一键保存、编译
  map <F7> :call CompileCode()<CR>

  " Ctrl + R 一键保存、运行
  map <F5> :call RunResult()<CR>

  "方便远程连接时所有模式关闭鼠标，方便使用鼠标拷贝
  map <leader>ms :call ToggleMouse()<cr>

  "某些时候自动换目录不方便
  map <leader>ad :call ToggleAutochdir()<cr>

  "当前行和列高亮开关
  map <leader>hc :call ToggleCursorLine()<cr>

  "粘贴模式开关
  map <leader>ps :call TogglePaste()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "语法高亮
set guifont=Monaco:h13       " 字体 && 字号

if has("gui_running")
  set guioptions= "菜单栏、工具栏等都不要了
  au GUIEnter * simalt ~x  " 窗口启动时自动最大化
  let psc_style='cool'
  colorscheme blackboard       " 着色模式
  "colorscheme torte
  "colorscheme desert
else
  set background=dark
  "colorscheme darkburn       " 着色模式
  "colorscheme torte
  colorscheme desert
endif

"高亮当前行当前列
if has("gui_running")
  set cursorline
  set cursorcolumn
  hi cursorline guibg=#191E2F
  hi CursorColumn guibg=#191E2F
else
  set nocursorline
  set nocursorcolumn
  "hi cursorline ctermbg=LightMagenta
  "hi CursorColumn ctermbg=LightMagenta
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cc=0  "不高亮任何列
set showcmd "显示输入的字符
set mousehide "默认不显示鼠标
set so=3 "移动时光标最多离底部3行
set ruler "显示行号和列号
set wildmenu "加强自动补全
set cmdheight=1 "命令行占1行
set nu "显示行号
set lazyredraw "减少重绘
set hid "放弃缓冲区时隐藏而不卸载
set backspace=eol,start,indent
set whichwrap=b,s,<,>,[,] "使指定的左右移动光标的键在行首或行尾可以移到前一行或者后一行
set ignorecase smartcase "搜索时忽略大小写，但是如果关键字里有大小写就严格匹配
set incsearch "搜索时动态调到第一个匹配的位置
set wrapscan "搜索到文件末时循环到第一个搜索结果
set magic
set showmatch "括号匹配暂时跳转
set mat=2 "配对符号高亮"
set hlsearch "高亮搜索匹配的结果

try
  set switchbuf=usetab "打开缓冲时在原来的窗口打开
  set stal=1 "至少有两个标签页时才显示标签栏
catch
endtry

"每行超过80个的字符用下划线标示
au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.erb,*.hs,*.vim,*.php 2match Underlined /.\%81v/

  """"""""""""""""""""""""""""""
  " => Statusline
  """"""""""""""""""""""""""""""
  set laststatus=2 "状态栏有两行
  "set statusline=\     "初始化为一个空格
  "set statusline+=%m   "是否被修改
  "set statusline+=%r   "是否是只读
  "set statusline+=%h   "是否是帮助文档
  "set statusline+=%w   "是否是预览窗口
  "set statusline+=\ [%{strlen(&ft)?&ft:'none'} "文件类型
  "set statusline+=,\ %{&fileencoding}  "文件编码
  "set statusline+=,\ %{&fileformat}]  "文件格式
  "set statusline+=\ \ Line:\ %l/%L:%c  "行号\总行号:列号
  "set statusline+=\ \ Char:\ %b\ 0x%B  "字符十进制和十六进制的ASCII值
  "set statusline+=\ \ %<CWD:\ %r%{getcwd()} "显示当前工作目录,%<表示过长就从该位置收缩
  "set statusline+=\ \ File:\ %f   "文件路径

  """"""""""""""""""""""""""""""
  " => Indent
  """"""""""""""""""""""""""""""
  set expandtab "插入tab时换成合适数量的空格
  set shiftwidth=4 "缩进一步使用的空格数目
  set smarttab "行首的tab用合适的空格代替
  set tabstop=4 et "文件里tab代表的空格数
  set lbr "打开linebreak
  set tw=0 "textwidth, 一行的最大宽度
  set list "显示不可见字符"
  "listchars tabe用+---显示，尾部空格用-显示，eol不显示"
  set lcs=tab:+-,trail:- "tab用+---显示，行末空格用-显示
  set ai "autoindent 按语法自动缩进
  set si "smartindent 开启新行时自动缩进
  set cindent "按C的语法缩进
  set wrap  "到屏幕边会回绕

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"File format and encoding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ambiwidth=double "使用 US-ASCII 字符两倍的宽度，帮助识别CJK
set fo+=mB "formatoptions"
set ffs=unix,dos,mac "文件格式支持"
set encoding=utf-8 "默认编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
if has("win32")
  "set fileencoding=chinese
  set termencoding=gbk
else
  "set fileencoding=utf-8
  set termencoding=utf-8 "终端下的编码
endif
set langmenu=zh_CN.UTF-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :Tlist              调用TagList
let Tlist_Show_One_File=1                    " 只显示当前文件的tags
let Tlist_Exit_OnlyWindow=1                  " 如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_Use_Right_Window=0                 " 在左侧窗口中显示
let Tlist_File_Fold_Auto_Close=1             " 自动折叠
let g:tagbar_left=1

" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=1

"用:LoadTemplate 根据文件后缀自动加载模板
let g:template_path=g:_vimfiles.'/template'

" :AuthorInfoDetect   自动添加作者、时间等信息，本质是NERD_commenter && authorinfo的结合
let g:vimrc_author='lightxue'
let g:vimrc_email='bkmgtp@gmail.com'
"let g:vimrc_homepage='http://www.yourpage.com'

" 设置编码
let g:vimwiki_w32_dir_enc = 'utf-8'
" 使用鼠标映射
let g:vimwiki_use_mouse = 1
" 不要将驼峰式词组作为 Wiki 词条
let g:vimwiki_camel_case = 0
let g:vimwiki_menu = ''
let g:vimwiki_CJK_length = 1
let g:wimwiki_menu = ''
let g:wimwiki_flolding = 1
" 声明可以在wiki里面使用的HTML标签
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,del,code,red,center,left,right,h4,h5,h6,pre'
let g:vimwiki_list = [{'path': '~/vimwiki/personal',
                    \ 'path_html': '~/vimwiki/html/personal',
                    \ 'html_header': '~/vimwiki/template/header.tpl',
                    \ 'html_footer': '~/vimwiki/template/footer.tpl'},
                    \ {'path': '~/vimwiki/blog',
                    \ 'path_html': '~/vimwiki/html/blog',
                    \ 'html_header': '~/vimwiki/template/blog_header.tpl',
                    \ 'html_footer': '~/vimwiki/template/blog_footer.tpl'}
                    \ ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"高亮当前行当前列
function! TogglePaste()
  if &paste
    set nopaste
    echo 'paste off'
  else
    set paste
    echo 'paste on'
  endif
endfunction

"高亮当前行当前列
function! ToggleCursorLine()
  if &cursorline
    set nocursorline
    set nocursorcolumn
    echo 'cursorline off'
  else
    set cursorline
    set cursorcolumn
    echo 'cursorline on'
  endif
endfunction

function! ToggleAutochdir()
  if &autochdir
    set noautochdir
    echo 'autochdir off'
  else
    set autochdir
    echo 'autochdir on'
  endif
endfunction

function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    set nonu
    echo 'mouse off'
  else
    set mouse=a
    set nu
    echo 'mouse on'
  endif
endfunction

function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . ""
  else
    execute "normal /" . l:pattern . ""
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"function! OpenPair(char)
"    let PAIRs = {
"                \ '{' : '}',
"                \ '[' : ']',
"                \ '(' : ')',
"                \ '<' : '>'
"                \}
"    if line('$')>2000
"        let line = getline('.')
"
"        let txt = strpart(line, col('.')-1)
"    else
"        let lines = getline(1,line('$'))
"        let line=""
"        for str in lines
"            let line = line . str . "\n"
"        endfor
"
"        let blines = getline(line('.')-1, line("$"))
"        let txt = strpart(getline("."), col('.')-1)
"        for str in blines
"            let txt = txt . str . "\n"
"        endfor
"    endif
"    let oL = len(split(line, a:char, 1))-1
"    let cL = len(split(line, PAIRs[a:char], 1))-1
"
"    let ol = len(split(txt, a:char, 1))-1
"    let cl = len(split(txt, PAIRs[a:char], 1))-1
"
"    if oL>=cL || (oL<cL && ol>=cl)
"        return a:char . PAIRs[a:char] . "\<Left>"
"    else
"        return a:char
"    endif
"endfunction
"
"function! ClosePair(char)
"    if getline('.')[col('.')-1] == a:char
"        return "\<Right>"
"    else
"        return a:char
"    endif
"endf
"
"function! CompleteQuote(quote)
"    let ql = len(split(getline('.'), a:quote, 1))-1
"    let slen = len(split(strpart(getline("."), 0, col(".")-1), a:quote, 1))-1
"    let elen = len(split(strpart(getline("."), col(".")-1), a:quote, 1))-1
"    let isBefreQuote = getline('.')[col('.') - 1] == a:quote
"
"    if '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
"" for vim comment.
"        return a:quote
"    elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
"" for Name's Blog.
"        return a:quote
"    elseif (ql%2)==1
"" a:quote length is odd.
"        return a:quote
"    elseif ((slen%2)==1 && (elen%2)==1 && !isBefreQuote) || ((slen%2)==0 && (elen%2)==0)
"        return a:quote . a:quote . "\<Left>"
"    elseif isBefreQuote
"        return "\<Right>"
"    else
"        return a:quote . a:quote . "\<Left>"
"    endif
"endfunction

  """"""""""""""""""""""""""""""
  " => Compile & Run
  """"""""""""""""""""""""""""""
  " 编译C源文件
  func! CompileGcc()
      exec "w"
      "let compilecmd="!gcc -Wall -pedantic -std=c99 "
      let compilecmd="!gcc -Wall"
      let compileflag="-o %<"
      exec compilecmd." % ".compileflag
  endfunc

  " 编译C++源文件
  func! CompileCpp()
      exec "w"
      "let compilecmd="!g++ -Wall -pedantic -std=c++98 "
      let compilecmd="!g++ -Wall""
      let compileflag="-o %<"
      exec compilecmd." % ".compileflag
  endfunc

  " 编译Java源文件
  func! CompileJava()
    exec "w"
      exec "!javac %"
  endfunc

  " 编译Haskell源文件
  func! CompileHaskell()
    exec "w"
    let compilecmd="!ghc --make "
    let compileflag="-o %<"
    exec compilecmd." % ".compileflag
  endfunc

  " 根据文件类型自动选择相应的编译函数
  func! CompileCode()
        exec "w"
        if &filetype == "c"
            exec "call CompileGcc()"
        elseif &filetype == "cpp"
            exec "call CompileCpp()"
        elseif &filetype == "java"
            exec "call CompileJava()"
        elseif &filetype == "haskell"
            exec "call CompileHaskell()"
        elseif &filetype == "lua"
            exec "!lua %<.lua"
        elseif &filetype == "perl"
            exec "!perl %<.pl"
          elseif &filetype == "python"
            exec "!python %<.py"
        elseif &filetype == "ruby"
            exec "!ruby %<.rb"
          endif
  endfunc

  " 运行可执行文件
  func! RunResult()
          exec "w"
        if &filetype == "c"
            exec "! %<"
        elseif &filetype == "cpp"
            exec "! %<"
        elseif &filetype == "java"
            exec "!java %<"
        elseif &filetype == "haskell"
            exec "! %<"
        elseif &filetype == "lua"
            exec "!lua %<.lua"
        elseif &filetype == "perl"
            exec "!perl %<.pl"
        elseif &filetype == "python"
            exec "!python %<.py"
        elseif &filetype == "ruby"
            exec "!ruby %<.rb"
          endif
  endfunc

" config about neocompcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 0
" When you input 'ho-a',neocomplcache will select candidate 'a'.
let g:neocomplcache_enable_quick_match = 1

" Define dictionary.
"let g:neocomplcache_snippets_dir=$VIMFILES."/snippets"
let g:neocomplcache_snippets_dir=g:_vimfiles."/snippets"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr><C-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-z>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"

inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" <TAB>: completion. THIS HAS NO USE WHEN WITH SNIPMATE
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <SPACE>: completion.
inoremap <expr><space>  pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<SPACE>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

"let g:Powerline_symbols = 'fancy'
"let g:pydiction_location = '$VIM/vimfiles/ftplugin/complete-dict'
let g:pydiction_location = g:_vimfiles."/ftplugin/complete-dict"

autocmd FileType php setlocal let b:surround_112 = "<?php \n ?>"

