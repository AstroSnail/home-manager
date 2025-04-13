source $VIMRUNTIME/defaults.vim
autocmd! vimHints
runtime ftplugin/man.vim
packadd! matchit

set formatoptions+=j keywordprg=:Man sidescroll=1 sidescrolloff=10 nowrap
set listchars+=tab:\ \ \|,space:.,extends:>,precedes:<,nbsp:+

" make scrolling reachable from usual navigation keys
" for some reason <C-S-n/p> don't work?
" TODO: investigate
noremap <C-j> <C-e>
"noremap <C-S-j> <C-S-n>
noremap <C-S-j> <C-d>
noremap <C-k> <C-y>
"noremap <C-S-k> <C-S-p>
noremap <C-S-k> <C-u>

" Netrw
" work around broken netrw#own#PathJoin()
let g:netrw_home = expand('~/.vim')

" EasyMotion
noremap gs <Plug>(easymotion-prefix)
