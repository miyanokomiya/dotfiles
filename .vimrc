"---------------------
" dein
"---------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml      = s:dein_dir . '/.dein.toml'
  let s:lazy_toml = s:dein_dir . '/.dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"----------------------------------------
" 基本設定
"----------------------------------------
set number
set nowritebackup
set nobackup
set virtualedit=block
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildoptions+=pum
set wrapscan
set incsearch
set hlsearch
set hidden
set pyxversion=3
set completeopt=noselect,menuone
set isfname

"----------------------------------------
" 表示設定
"----------------------------------------
" エラーメッセージの表示時にビープを鳴らさない
set noerrorbells
" Windowsでパスの区切り文字をスラッシュで扱う
set shellslash
" 対応する括弧やブレースを表示
set showmatch matchtime=1
" インデント方法の変更
set cinoptions+=:0
set cmdheight=2
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" コマンドラインの履歴を10000件保存する
set history=10000
" タブ
set expandtab
set shiftwidth=2
set tabstop=2
" ツールバーを非表示にする
set guioptions-=T
" yでコピーした時にクリップボードに入る
set guioptions+=a
" メニューバーを非表示にする
set guioptions-=m
" 右スクロールバーを非表示
set guioptions+=R
" 対応する括弧を強調表示
set showmatch
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" スワップファイルを作成しない
set noswapfile
" 検索にマッチした行以外を折りたたむ(フォールドする)機能
set nofoldenable
" タイトルを表示
set title
" 行番号の表示
set number
set clipboard+=unnamedplus
" Escの2回押しでハイライト消去
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><ESC>
" すべての数を10進数として扱う
set nrformats=
" 行をまたいで移動
set whichwrap=b,s,h,l,<,>,[,],~
" バッファスクロール
set mouse=a
" カーソル行強調
set cursorline

augroup MySaveCursor
  autocmd!
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
augroup END

" インデント
filetype plugin indent on
" シンタックスハイライト
syntax enable
" not stop completion $ & /
setlocal iskeyword+=$
setlocal iskeyword+=-

" :grep後に:cw
autocmd QuickFixCmdPost *grep* copen

" textファイル編集時の自動改行解除
autocmd FileType text setlocal textwidth=0

" 閉じカッコ補完と改行
inoremap ({<Enter> ({})<Left><Left><CR><ESC><S-o>
inoremap [{<Enter> [{}]<Left><Left><CR><ESC><S-o>
inoremap ([<Enter> ([])<Left><Left><CR><ESC><S-o>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" インサートモードで左右移動
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" コマンドモードでも左右移動
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
" 先頭移動（<C-a>はコマンド候補補完だが使いにくいしTabで十分）
cnoremap <C-a> <C-b>
" コマンド履歴フィルタリングを有効にする -> pum表示中を考慮
cnoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<Up>"
cnoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<Down>"

" 上下余裕をもってスクロール
set scrolloff=5

" ジャンプ後スクロール調整
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap <C-i> <C-i>zz
nnoremap <C-o> <C-o>zz
nnoremap <S-g> <S-g>3<C-e>

" vueのシンタックスが消える問題への対処(deinのhookでは効かなかった)
autocmd FileType vue syntax sync fromstart
autocmd FileType svelte syntax sync fromstart

" 括弧内での改行
inoremap <silent> <C-o> <CR><ESC><S-o>

" terminalモードでもESCでノーマルになりたい
tnoremap <silent> <ESC> <C-\><C-n>

" 前のバッファにトグル
nnoremap <silent> <Space><Tab> <C-^>zz

" terminalショートカット
nnoremap <silent> <Space>t :terminal<CR>i

" マークダウンで色々消えるので無効化
set conceallevel=0

" 保存時にディレクトリを作る
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

function! ClipText(data)
  let @0=a:data
  let @"=a:data
  let @*=a:data " ヤンク時と同様にレジスタへ登録
  echo "clip: ".a:data
  return "\<ESC>" " returnなしだとカーソルが行頭に移動してしまう
endfunction
" カレントファイルパスをヤンク（workspaceからのパス）
nnoremap <expr> <C-g> ClipText(fnamemodify(expand("%"), ":~:."))
" カレントファイル名をヤンク
nnoremap <expr> <Space><C-g> ClipText(expand('%:t'))

" キャメル、スネーク、ケバブ変換
nnoremap <Space>c viw:s/\%V\(_\\|-\)\(.\)/\u\2/g<CR>
nnoremap <Space>_ viw:s/\%V\([A-Z]\)/_\l\1/g<CR>
nnoremap <Space>- viw:s/\%V\([A-Z]\)/-\l\1/g<CR>
xnoremap <Space>c :s/\%V\(_\\|-\)\(.\)/\u\2/g<CR>
xnoremap <Space>_ :s/\%V\([A-Z]\)/_\l\1/g<CR>
xnoremap <Space>- :s/\%V\([A-Z]\)/-\l\1/g<CR>

" マークジャンプコマンド入れ替え
nnoremap ' `
nnoremap ` '

" Mark the yank position
augroup mark_yank_position
  au!
  au TextYankPost * normal mY
augroup END
nnoremap Y 'Y

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.tag set filetype=html

" 単語を入力し直す => 補完を呼び出したい
nnoremap <Space>y ciw<C-r>"

" commitメッセージの自動改行を抑制
au FileType gitcommit setlocal tw=200

" 現在日付入力
inoremap <C-r>d <C-R>=strftime("%Y-%m-%d")<CR>
inoremap <C-r><C-d> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

" 検索ワード貼り付け(関数経由でないとなぜかうまくいかず)
function! PasteSearchWord()
  return substitute(@/, '\\<\|\\>', '', 'g')
endfunction
inoremap <expr> <C-r>? PasteSearchWord()

" Move to next/previous capital letter
nmap <silent> <Space>w :call search('[A-Z]', 'W')<CR>

" Hide healthcheck warnings
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0

" Jump to Backlog's git
command! -range Backlog exe "!gitb browse show %\\#" . (<line1> == <line2> ? <line1> : <line1> . "-" . <line2>)
"--------
" 自作プラグイン関連
"--------

" ブロック単位ジャンプ
nnoremap <silent> <C-k> :BlockJumpUp<CR>
nnoremap <silent> <C-j> :BlockJumpDown<CR>
xnoremap <silent> <C-k> <ESC>:BlockJumpUp<CR>m>gv
xnoremap <silent> <C-j> <ESC>:BlockJumpDown<CR>m>gv
"--------
