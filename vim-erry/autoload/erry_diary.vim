vim9script

g:erry_diary_method = 'drop'
g:erry_diary_path = expand('~/tulpa')

export def New(mods: string, topic: string, date: string = '')
	# TODO: refactor into a different design where date
	# may eval into a number directly (e.g. "localtime()")
	# and make better tooling for dates
	var parsed_date = strptime('%F', date)
	if parsed_date == 0
		parsed_date = localtime()
	endif
	var file_path = g:erry_diary_path
		.. strftime('/%G-W%V/%F-', parsed_date)
		.. topic
	execute mods .. ' ' .. g:erry_diary_method .. ' ' .. file_path
	mkdir(expand('%:p:h'), 'p')
enddef
