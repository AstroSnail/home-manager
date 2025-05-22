source $VIMRUNTIME/defaults.vim
autocmd! vimHints
runtime ftplugin/man.vim
packadd! matchit

set hlsearch nowrap
set formatoptions+=j keywordprg=:Man laststatus=2 showtabline=2
set sidescroll=1 sidescrolloff=10
set listchars+=tab:\ \ \|,space:.,extends:>,precedes:<,nbsp:+
set viminfo+=r/run/media,r/tmp

" make scrolling reachable from usual navigation keys
" for some reason <C-S-n/p> don't work?
" TODO: investigate
noremap <C-j> <C-e>
"noremap <C-S-j> <C-S-n>
noremap <C-S-j> <C-d>
noremap <C-k> <C-y>
"noremap <C-S-k> <C-S-p>
noremap <C-S-k> <C-u>

" work around broken :terminal handling of numpad
" keys when they're ambiguous with editpad keys
tmap <kHome> <xHome>
tmap <kEnd> <xEnd>
tmap <kPageUp> <PageUp>
tmap <kPageDown> <PageDown>

" Netrw
" work around broken netrw#own#PathJoin()
let g:netrw_home = expand('~/.vim')

" EasyMotion
map gs <Plug>(easymotion-prefix)
