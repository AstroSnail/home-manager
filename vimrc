vim9script

packadd! comment
packadd! editorconfig
packadd! matchit
packadd! nohlsearch

source $VIMRUNTIME/defaults.vim
autocmd! vimHints
runtime ftplugin/man.vim

&autoindent = true
&breakindent = true
&formatoptions = "tcroqj"
&hlsearch = true
&ignorecase = true
&joinspaces = false
&keywordprg = ":Man"
&laststatus = 2
&linebreak = true
&listchars = "eol:$,tab:  |,space:.,extends:>,precedes:<,nbsp:+"
&showbreak = "> "
&showtabline = 2
&smartcase = true
&viminfo = "'100,<50,s10,h,r/run/media,r/tmp"
&wildignorecase = true

# edit git commit messages in the enclosing vim editor
# (e.g. by running git commit in a :terminal)
# uses terminal-api to spawn a window for the commit message
$GIT_EDITOR = "vim-commit"

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
