# shellcheck disable=SC2016

erry_tput() {
	local IFS
	IFS=$'\n'
	tput -S <<<"$*"
}

erry_show_pipestatus() {
	local IFS p this_status

	for p in "${!erry_pipestatus[@]}"
	do
		if [[ ${erry_pipestatus[p]} -ne 0 ]]
		then
			this_status=
			this_status+=$(erry_tput 'bold' 'setaf 1')
			this_status+=${erry_pipestatus[p]}
			this_status+=$(erry_tput 'sgr0')
			erry_pipestatus[p]=${this_status}
		fi
	done

	IFS=\|
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
	# NOTE: enabling symbol requires subtracting 4 from COLUMNS below
	# output+=$'\u21B5 ' # carriage return
	# output+=$'\u23CE ' # return symbol
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
	output+='=(@PIPESTATUS@)'
	output+=$'\n'

	output+=$(erry_tput 'bold' 'setaf 2')
	output+=PWD
	output+=$(erry_tput 'sgr0')
	output+='=@PWD@'
	output+=$'\n'

	output+=$(erry_tput 'bold' 'setaf 2')
	output+=SHLVL
	output+=$(erry_tput 'sgr0')
	output+='=@SHLVL@'
	output+=$'\n'

	# preserve prior newline
	# strip this dot after command substitution
	output+=.

	printf %s "${output}"
}

erry_show_prompt_extra() {
	# save pipestatus first
	local erry_pipestatus=("${PIPESTATUS[@]}")

	local output replace
	output=${erry_prompt_extra}

	replace=$((COLUMNS > 2 ? COLUMNS - 2 : 1))
	# replace=$((COLUMNS > 4 ? COLUMNS - 4 : 1))
	output=${output/'%p1%d'/${replace}}

	replace=$(erry_show_pipestatus)
	output=${output/@PIPESTATUS@/${replace}}

	replace='\w'
	output=${output/@PWD@/${replace@P}}

	replace=${SHLVL}
	output=${output/@SHLVL@/${replace}}

	printf %s "${output}"

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
fi
