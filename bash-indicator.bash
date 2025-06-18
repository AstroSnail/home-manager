erry_enable_indicator_status() {
	# enable status line with indicator display type
	# (doesn't have corresponding terminfo code)
	printf '\e[1$~'
}

if [[ $TERM == xterm-erry ]]
then
	# run after every command
	# (in case it changed the status type)
	PROMPT_COMMAND+=(erry_enable_indicator_status)
fi
