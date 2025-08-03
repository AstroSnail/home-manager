vim9script

packadd! comment
packadd! editorconfig
packadd! matchit

source $VIMRUNTIME/defaults.vim

set autoindent breakindent hlsearch ignorecase nojoinspaces linebreak smartcase
set wildignorecase

set laststatus=2 showtabline=2

set keywordprg=:Man showbreak=>\ 

set formatoptions+=tcroqj
set listchars+=tab:\ \ \|,space:.,extends:>,precedes:<,nbsp:+
set sessionoptions-=options # work around bug with the comment plugin
set viminfo+=r/nix,r/run/media,r/tmp

# scrolling reference:
# CTRL-E/Y one line
# CTRL-D/U half window height
# CTRL-F/B full window height (-2 lines)
# NOTE: CTRL-J is LF, but this doesn't conflict
#       with enter, which sends CTRL-M (CR)
# noremap <C-J> <C-F>
# noremap <C-K> <C-B>
# use CTRL-L to call :nohlsearch
# vim-sensible also calls :diffupdate
nnoremap <C-L> <Cmd>nohlsearch<CR><C-L>
vnoremap <C-L> <Cmd>nohlsearch<CR><C-L>
# add undo step for CTRL-W
# helpful when editing and switching windows a lot
# defaults.vim covers CTRL-U but not CTRL-W
inoremap <C-W> <C-G>u<C-W>
# like doom-emacs (much more useful than :sleep)
map gs <Plug>(easymotion-prefix)

# i open the command-line window intentionally thanks
autocmd! vimHints CmdwinEnter

# :Man comes from a ftplugin instead of a normal plugin
runtime ftplugin/man.vim

# edit git commit messages in the enclosing vim editor
# (e.g. by running git commit in a :terminal)
# uses terminal-api to spawn a window for the commit message
$GIT_EDITOR = 'vim-commit'
