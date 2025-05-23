erry_set_title_to_command() {
	local bash_command=${BASH_COMMAND}

	# replace all C0 controls with a space
	local c0_fmt c0
	for c0_fmt in \\0{0..3}{0..7}
	do
		printf -v c0 "${c0_fmt}"
		bash_command=${bash_command//${c0}/ }
	done

	printf '\e]0;%s\e\\' "${bash_command}"
}

# functions evaluated in command substitution don't set global state
# TODO: investigate, are they evaluated in a subshell?
erry_show_pipestatus() {
	for p in "${!erry_pipestatus[@]}"
	do
		if [[ ${erry_pipestatus[${p}]} -ne 0 ]]
		then printf -v "erry_pipestatus[${p}]" '\e[1;31m%s\e[0m' "${erry_pipestatus[${p}]}"
		fi
	done
	IFS=\|
	printf %s "${erry_pipestatus[*]}"
}

# TODO: detect whether cursor is on the first column
erry_prompt_extra='\n'

erry_prompt_extra+='\e[0;1;32m'
erry_prompt_extra+='PIPESTATUS'
erry_prompt_extra+='\e[0m'
erry_prompt_extra+='=($(erry_show_pipestatus))\n'

erry_prompt_extra+='\e]0;\w\e\\'
erry_prompt_extra+='\e[1;32m'
erry_prompt_extra+='PWD'
erry_prompt_extra+='\e[0m'
erry_prompt_extra+='=\w\n'

erry_prompt_extra+='\e[1;32m'
erry_prompt_extra+='SHLVL'
erry_prompt_extra+='\e[0m'
erry_prompt_extra+='=${SHLVL}\n'

erry_show_prompt_extra() {
	# we don't need to restore $? as long as the command
	# gets its own place in the $PROMPT_COMMAND array
	local erry_pipestatus=("${PIPESTATUS[@]}")
	printf %s "${erry_prompt_extra@P}"
}

if [[ ${TERM} != dumb ]]
then
	PROMPT_COMMAND+=(erry_show_prompt_extra)
	PS1='\$ '

	# PS0 doesn't get an up-to-date BASH_COMMAND :<
	# DEBUG trap will have to do
	# TODO: append to trap
	if [[ -n $(trap -p DEBUG || true) ]]
	then printf 'DEBUG trap conflict!\n' >&2
	fi
	trap erry_set_title_to_command DEBUG
fi
