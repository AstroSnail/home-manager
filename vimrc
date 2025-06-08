packadd! comment
packadd! matchit
packadd! nohlsearch

source $VIMRUNTIME/defaults.vim
autocmd! vimHints
runtime ftplugin/man.vim

set hlsearch linebreak wildignorecase nowrap
set formatoptions+=j keywordprg=:Man laststatus=2 showbreak=>\  showtabline=2
set sidescroll=1 sidescrolloff=10
set listchars+=tab:\ \ \|,space:.,extends:>,precedes:<,nbsp:+
set viminfo+=r/run/media,r/tmp

" make scrolling reachable from usual navigation keys
" <C-S-n> and <C-S-p> are aliases of <C-f> and <C-b> respectively
"noremap <C-j> <C-e>
noremap <C-j> <C-f>
"noremap <C-S-j> <C-f>
"noremap <C-S-j> <C-d>
"noremap <C-k> <C-y>
noremap <C-k> <C-b>
"noremap <C-S-k> <C-b>
"noremap <C-S-k> <C-u>

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
