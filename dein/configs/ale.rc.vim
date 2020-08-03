let g:ale_sign_column_always = 1
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
let g:ale_fixers = {
  \  'elm': ['elm-format'],
  \  'json': ['prettier'],
  \  'html': ['prettier'],
  \  'css': ['prettier', 'stylelint'],
  \  'sass': ['prettier', 'stylelint'],
  \  'scss': ['prettier', 'stylelint'],
  \  'javascript': ['eslint'],
  \  'typescript': ['eslint'],
  \  'vue': ['eslint'],
  \  'svelte': ['prettier'],
  \  'python': ['autopep8', 'isort'],
  \  'rust': ['rustfmt'],
  \  'go': ['gofmt'],
  \  'markdown': [
  \   {buffer, lines -> {'command': 'textlint -c ~/.config/textlintrc -o /dev/null --fix --no-color --quiet %t', 'read_temporary_file': 1}}
  \  ],
  \ }
let g:ale_fix_on_save = 0
let g:ale_javascript_prettier_use_local_config = 1
nmap <silent> <Space>p <Plug>(ale_previous_wrap)
nmap <silent> <Space>n <Plug>(ale_next_wrap)
nnoremap <Space>f :ALEFix<CR>
