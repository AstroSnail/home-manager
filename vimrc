vim9script

packadd! comment
packadd! matchit
packadd! nohlsearch

source $VIMRUNTIME/defaults.vim
autocmd! vimHints
runtime ftplugin/man.vim

&breakindent = true
&hlsearch = true
&keywordprg = ":Man"
&laststatus = 2
&linebreak = true
&showbreak = "> "
&showtabline = 2
&sidescroll = 1
&sidescrolloff = 10
&wildignorecase = true
&wrap = false

# let ..= isn't quite as convenient as set +=
set formatoptions+=j
set listchars+=tab:\ \ \|,space:.,extends:>,precedes:<,nbsp:+
set viminfo+=r/run/media,r/tmp

# make scrolling reachable from usual navigation keys
# E/Y one line
# D/U half page
# F/B full page (-2 lines)
# NOTE: <C-J> is LF, but this doesn't conflict
#       with enter, which sends <C-M> (CR)
noremap <C-J> <C-F>
noremap <C-K> <C-B>

# add undo step for <C-W>
# defaults.vim covers <C-U> but not <C-W>
# very annoying when editing and switching windows a lot
inoremap <C-W> <C-G>u<C-W>

# EasyMotion
map gs <Plug>(easymotion-prefix)
