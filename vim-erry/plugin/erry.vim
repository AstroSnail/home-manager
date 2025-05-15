vim9script

import autoload 'erry_diary.vim' as diary
command -nargs=+ Diary diary.New(<q-mods>, <f-args>)
command -nargs=? Productive <mods> Diary productive <args>
