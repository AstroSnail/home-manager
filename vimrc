runtime defaults.vim
autocmd! vimHints

set formatoptions+=j selection=exclusive

" make scrolling reachable from usual navigation keys
" for some reason <C-S-n/p> don't work?
" TODO: investigate
noremap <C-j> <C-e>
"noremap <C-S-j> <C-S-n>
noremap <C-S-j> <C-d>
noremap <C-k> <C-y>
"noremap <C-S-k> <C-S-p>
noremap <C-S-k> <C-u>

" EasyMotion
noremap gs <Plug>(easymotion-prefix)
