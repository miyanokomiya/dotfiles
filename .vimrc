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
" メッセージ表示欄を2行確保
set cmdheight=2
" ステータス行を常に表示
set laststatus=2
" ウィンドウの右下にまだ実行していない入力中のコマンドを表示
set showcmd
" 省略されずに表示
set display=lastline
" タブ文字を CTRL-I で表示し、行末に $ で表示する
set list
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~
" 保存時に行末スペース削除
autocmd BufWritePre * :%s/\s\+$//ge
" コマンドラインの履歴を10000件保存する
set history=10000
" 入力モードでTabキー押下時に半角スペースを挿入
set expandtab
" インデント幅
set shiftwidth=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" ファイル内にあるタブ文字の表示幅
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
" ヤンクでクリップボードにコピー
" set clipboard=unnamed,autoselect
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

" 編集箇所のカーソルを記憶
if has("autocmd")
  augroup redhat
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

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

" 囲み系操作
noremap <silent> <C-s>' "zc''<ESC>"z<S-p>
xnoremap <silent> <C-s>" "zc""<ESC>"z<S-p>
xnoremap <silent> <C-s>` "zc``<ESC>"z<S-p>
xnoremap <silent> <C-s>] "zc[]<ESC>"z<S-p>
xnoremap <silent> <C-s>[ "zc[]<ESC>"z<S-p>
xnoremap <silent> <C-s>} "zc{}<ESC>"z<S-p>
xnoremap <silent> <C-s>{ "zc{}<ESC>"z<S-p>
xnoremap <silent> <C-s>( "zc()<ESC>"z<S-p>
xnoremap <silent> <C-s>) "zc()<ESC>"z<S-p>

" 選択範囲の前後文字削除
xnoremap <silent> <C-s>x "zdxX"z<S-p>

" 括弧内での改行
inoremap <silent> <C-o> <CR><ESC><S-o>

" terminalモードでもESCでノーマルになりたい
tnoremap <silent> <ESC> <C-\><C-n>

" 前回ファイルを開く
command! OL :e `=v:oldfiles[0]`
command! OLV :e `=v:oldfiles[1]` | :vs `=v:oldfiles[0]`
command! OLS :e `=v:oldfiles[1]` | :sp `=v:oldfiles[0]`

" カレント行周辺を上部ウィンドウに分割表示
nnoremap <silent> <C-w>u <C-w>s100<C-w>-5<C-w>+<C-w>j
nnoremap <silent> <C-w>U <C-w>k<C-w>q

" 前のバッファにトグル
nnoremap <silent> <Space><Tab> <C-^>zz

" terminalショートカット
nnoremap <silent> <Space>t :terminal<CR>i

" マークダウンで色々消えるので無効化
set conceallevel=0

" バッファ切替時にカーソル位置復元
au BufLeave * let b:winview = winsaveview()
au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif

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

" 辞書登録
let &dict = join(split(expand("$HOME/.config/nvim/dict/**"), "\n"), ",")

function! ClipText(data)
  let @0=a:data
  let @"=a:data
  let @*=a:data " ヤンク時と同様にレジスタへ登録
endfunction
" カレントファイルパスをヤンク FIXME ３項演算子使わないで書けない？
nnoremap <expr> <C-g> ClipText(expand('%')) ? "" : "\<C-g>"

"--------
" 自作プラグイン関連
"--------

" ブロック単位ジャンプ
nnoremap <silent> <C-k> :BlockJumpUp<CR>
nnoremap <silent> <C-j> :BlockJumpDown<CR>
xnoremap <silent> <C-k> <ESC>:BlockJumpUp<CR>m>gv
xnoremap <silent> <C-j> <ESC>:BlockJumpDown<CR>m>gv

"--------
