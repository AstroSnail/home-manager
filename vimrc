vim9script

packadd! comment
packadd! editorconfig
packadd! matchit
packadd! nohlsearch

source $VIMRUNTIME/defaults.vim
autocmd! vimHints
runtime ftplugin/man.vim

set autoindent breakindent hlsearch ignorecase nojoinspaces linebreak smartcase
set wildignorecase

set laststatus=2 showtabline=2

set keywordprg=:Man showbreak=>\ 

set formatoptions+=tcroqj
set listchars+=tab:\ \ \|,space:.,extends:>,precedes:<,nbsp:+
set sessionoptions-=options
set viminfo+=r/nix,r/run/media,r/tmp

# make scrolling reachable from usual navigation keys
# E/Y one line
# D/U half page
# F/B full page (-2 lines)
# NOTE: <C-J> is LF, but this doesn't conflict
#       with enter, which sends <C-M> (CR)
noremap <C-J> <C-F>
noremap <C-K> <C-B>

# add undo step for <C-W>
# helpful when editing and switching windows a lot
# defaults.vim covers <C-U> but not <C-W>
inoremap <C-W> <C-G>u<C-W>

map gs <Plug>(easymotion-prefix)

# edit git commit messages in the enclosing vim editor
# (e.g. by running git commit in a :terminal)
# uses terminal-api to spawn a window for the commit message
$GIT_EDITOR = "vim-commit"
