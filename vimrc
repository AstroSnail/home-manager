vim9script

packadd! comment
packadd! editorconfig
packadd! matchit

source $VIMRUNTIME/defaults.vim

set autoindent breakindent hlsearch ignorecase nojoinspaces linebreak smartcase
set wildignorecase
set laststatus=2 showtabline=2
&formatoptions = 'tcroqj'
&keywordprg = ':Man'
&listchars = 'eol:$,tab:  |,space:.,extends:>,precedes:<,nbsp:+'
&showbreak = '> '
set sessionoptions-=options # work around bug with the comment plugin
set viminfo+=r/nix,r/run/media,r/tmp

# enable cursor shapes
&t_SI = "\<Esc>[6 q"
&t_SR = "\<Esc>[4 q"
&t_EI = "\<Esc>[2 q"

# fix underline styles
&t_Cs = ''
&t_Us = "\<Esc>[21m"
&t_ds = ''
&t_Ds = ''
&t_Ce = ''

$GIT_EDITOR = 'vim-commit'

# scrolling reference:
# CTRL-E/Y one line
# CTRL-D/U half window height
# CTRL-F/B full window height (-2 lines)
# NOTE: CTRL-J is LF, but this doesn't conflict
#       with enter, which sends CTRL-M (CR)
# noremap <C-J> <C-F>
# noremap <C-K> <C-B>

# add undo step for CTRL-W
# helpful when editing and switching windows a lot
# defaults.vim covers CTRL-U but not CTRL-W
inoremap <C-W> <C-G>u<C-W>

# like doom-emacs (much more useful than :sleep)
map gs <Plug>(easymotion-prefix)

# unhighlight searches with Meta-u, a bit like less
# (supposing metaSendsEscape as a metaphor, because less really parses ESC-u)
nmap <M-u> <Cmd>nohlsearch<CR>

autocmd! vimHints CmdwinEnter

# :Man comes from a ftplugin instead of a normal plugin
runtime ftplugin/man.vim
