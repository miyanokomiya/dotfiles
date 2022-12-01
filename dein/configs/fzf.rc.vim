let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" dotファイルを含める&プレビュー
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'ag --hidden --ignore .git -g ""'}), <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Agrep
  \ call fzf#vim#grep(
  \   'ag --column --color --hidden --ignore .git '.shellescape(<q-args>),
  \   0, fzf#vim#with_preview('right:50%', '?'), <bang>0)

" floating windowで表示する
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

" Require `wordnet`
function! DictionaryFZF()
  return fzf#vim#complete({
    \   'source': 'cat /usr/share/dict/words',
    \   'options': ['-i',
    \               '--preview', 'wn {} -over',
    \               '--preview-window', 'up:60%']})
endfunction

nnoremap <C-p> :Files<CR>
nnoremap <Space>b :Buffers<CR>
nnoremap <Space>A :Ag<CR>
nnoremap <Space>a :Agrep<Space>
nnoremap <Space>m :Marks<CR>
nnoremap <Space>hf :History<CR>
nnoremap <Space>h: :History:<CR>
nnoremap <Space>h/ :History/<CR>
inoremap <expr> <c-x><c-k> DictionaryFZF()
