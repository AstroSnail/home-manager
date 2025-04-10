vim9script

import autoload 'diary.vim'
command -nargs=+ TestDiary {
	diary.OpenCommand(<f-args>)
}
