vim9script

import autoload 'erry_diary.vim'
command -nargs=+ Diary erry_diary.New(<q-mods>, <f-args>)
command -nargs=? Productive <mods> Diary productive <args>
