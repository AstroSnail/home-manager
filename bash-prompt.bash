erry_show_pipestatus() {
	local p
	for p in "${!erry_pipestatus[@]}"
	do
		if [[ ${erry_pipestatus[p]} -ne 0 ]]
		then
			local this_status=
			this_status+=$(tput bold)
			this_status+=$(tput setaf 1)
			this_status+=${erry_pipestatus[p]}
			this_status+=$(tput sgr0)
			erry_pipestatus[p]=${this_status}
		fi
	done

	local IFS=\|
	printf %s "${erry_pipestatus[*]}"
}

# NOTE: output of this will be parsed as a printf format string!!!
# make sure to get the right amount of backslashes, and avoid percent-signs
# unless intended! (and i guess hope none of the tputs use them? ST \e\\ comes
# to mind...)
erry_gen_prompt_extra() {
	tput sgr0

	# extra space in case of xenl: if the cursor started already at the
	# last column, then the symbol gets written there, and the subsequent
	# cursor movement cancels the eat-newline state, returning the cursor
	# to the last column, where the final spaces to trigger wrapping will
	# overwrite the symbol
	printf '↵ '
	# printf '⏎ '
	# parameter left unset, will be passed to printf later
	local cuf
	cuf=$(tput cuf)
	printf %s "${cuf/'%p1'/}"
	# TODO: test non-xenl terminal
	if tput xenl
	then printf '  '
	else printf ' '
	fi
	tput -S <<-'!'
		cr
		el
	!

	tput -S <<-'!'
		bold
		setaf 2
	!
	printf PIPESTATUS
	tput sgr0
	printf '=($(erry_show_pipestatus))\n'

	tput -S <<-'!'
		bold
		setaf 2
	!
	printf PWD
	tput sgr0
	printf '=\\\\w\n'

	tput -S <<-'!'
		bold
		setaf 2
	!
	printf SHLVL
	tput sgr0
	printf '=${SHLVL}\n'

	# preserve prior newline
	# strip this dot after command substitution
	printf '.'
}

erry_show_prompt_extra() {
	# save pipestatus so it's visible through
	# command substitution (subshell)
	local erry_pipestatus=("${PIPESTATUS[@]}")

	local cufs=$((COLUMNS > 4 ? COLUMNS - 4 : 1))
	local erry_prompt_extra_ready
	printf -v erry_prompt_extra_ready "${erry_prompt_extra}" "${cufs}"

	printf %s "${erry_prompt_extra_ready@P}"

	# we don't need to restore $? as long as the command
	# gets its own place in the $PROMPT_COMMAND array
}

if [[ ${TERM} != dumb ]]
then
	erry_prompt_extra=$(erry_gen_prompt_extra)
	erry_prompt_extra=${erry_prompt_extra%.}

	PROMPT_COMMAND+=(erry_show_prompt_extra)
	PS1='\$ '
	bind 'set emacs-mode-string' # to the empty string
fi
