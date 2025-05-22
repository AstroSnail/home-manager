erry_set_title_to_command() {
	# TODO: sanitize
	printf '\e]0;%s\e\\' "${BASH_COMMAND}"
}

erry_show_pipestatus() {
	local pipestatus=("${PIPESTATUS[@]}")
	for p in "${!pipestatus[@]}"
	do
		if [[ ${pipestatus[${p}]} -ne 0 ]]
		then printf -v "pipestatus[${p}]" '\e[1;31m%s\e[0m' "${pipestatus[${p}]}"
		fi
	done
	local IFS=\|
	printf %s "${pipestatus[*]}"
}

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
	# trust that we don't need to save $? and
	# $PIPESTATUS for the interactive user
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
