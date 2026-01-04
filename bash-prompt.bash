# shellcheck disable=SC2016

erry_tput() {
	local IFS=$'\n'
	tput -S <<<"$*"
}

erry_show_pipestatus() {
	local p
	for p in "${!erry_pipestatus[@]}"
	do
		if [[ ${erry_pipestatus[p]} -ne 0 ]]
		then
			local this_status=
			this_status+=$(erry_tput 'bold' 'setaf 1')
			this_status+=${erry_pipestatus[p]}
			this_status+=$(erry_tput 'sgr0')
			erry_pipestatus[p]=${this_status}
		fi
	done

	local IFS=\|
	printf %s "${erry_pipestatus[*]}"
}

erry_gen_prompt_extra() {
	local output=
	output+=$(erry_tput 'sgr0')

	# extra space in case of xenl: if the cursor started already at the
	# last column, then the symbol gets written there, and the subsequent
	# cursor movement cancels the eat-newline state, returning the cursor
	# to the last column, where the final spaces to trigger wrapping will
	# overwrite the symbol
	output+='↵ '
	# output+='⏎ '
	# parameter left unset, placeholder will be replaced later
	output+=$(erry_tput 'cuf')
	# TODO: test non-xenl terminal
	if tput xenl
	then output+='  '
	else output+=' '
	fi
	output+=$(erry_tput 'cr' 'el')

	output+=$(erry_tput 'bold' 'setaf 2')
	output+=PIPESTATUS
	output+=$(erry_tput 'sgr0')
	output+='=($(erry_show_pipestatus))\n'

	output+=$(erry_tput 'bold' 'setaf 2')
	output+=PWD
	output+=$(erry_tput 'sgr0')
	output+='=\w\n'

	output+=$(erry_tput 'bold' 'setaf 2')
	output+=SHLVL
	output+=$(erry_tput 'sgr0')
	output+='=${SHLVL}\n'

	# preserve prior newline
	# strip this dot after command substitution
	output+=.

	printf %s "${output}"
}

erry_show_prompt_extra() {
	# save pipestatus so it's visible through
	# command substitution (subshell)
	local erry_pipestatus=("${PIPESTATUS[@]}")

	local cufs=$((COLUMNS > 4 ? COLUMNS - 4 : 1))
	local erry_prompt_extra_ready=${erry_prompt_extra/'%p1%d'/${cufs}}

	printf %s "${erry_prompt_extra_ready@P}"

	# we don't need to restore $? as long as the command
	# gets its own place in the $PROMPT_COMMAND array
}

if [[ ${TERM} != dumb ]]
then
	# save on tput calls
	erry_prompt_extra=$(erry_gen_prompt_extra)
	erry_prompt_extra=${erry_prompt_extra%.}

	PROMPT_COMMAND+=(erry_show_prompt_extra)
	PS1='\$ '
	bind 'set emacs-mode-string' # to the empty string
fi
