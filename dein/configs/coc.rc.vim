" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd ColorScheme * highlight CocHighlightText ctermfg=Black ctermbg=darkgreen

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

imap <C-j> <Plug>(coc-snippets-expand-jump)
command! CocSnippets :CocCommand snippets.editSnippets

" Accept selected completion item or notify coc.nvim to format
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm():
      \ "\<C-y>"
