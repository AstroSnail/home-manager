vim9script

packadd! comment
packadd! editorconfig
packadd! matchit

source $VIMRUNTIME/defaults.vim
runtime ftplugin/man.vim
autocmd! vimHints CmdwinEnter

set autoindent autoread breakindent formatoptions=tcroqj hlsearch nojoinspaces
set laststatus=2 linebreak showtabline=2 nostartofline wildignorecase
set sessionoptions-=options # work around bug with the comment plugin
&keywordprg = ':Man'
&listchars = 'eol:$,tab:  |,space:.,extends:>,precedes:<,nbsp:+'
&showbreak = '> '

if split(&term, '-')[0] == 'xterm'
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
endif

# add undo step for CTRL-W
# helpful when editing and switching windows a lot
# defaults.vim covers CTRL-U but not CTRL-W
inoremap <C-W> <C-G>u<C-W>

# unhighlight searches with Meta-u, a bit like less
# supposes metaSendsEscape as a metaphor, because less really parses ESC-u
# while vim enables terminal features (e.g. modifyOtherKeys) to distinguish
# this from :undo
# some terminals always send meta as escape, and can't reach this mapping!
nmap <M-u> <Cmd>nohlsearch<CR>

# like doom-emacs, much more useful than :sleep
map gs <Plug>(easymotion-prefix)
g:EasyMotion_startofline = 0
