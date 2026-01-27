erry_gen_tput() {
	declare -Ag erry_tput

	erry_tput['cr']=$(tput cr)

	# parameter left unset, placeholder will be replaced later
	erry_tput['cuf']=$(tput cuf)

	# ideally SGR 1;31
	erry_tput['fR']=$(tput bold)
	erry_tput['fR']+=$(tput setaf 1)

	# ideally SGR 1;32
	erry_tput['fG']=$(tput bold)
	erry_tput['fG']+=$(tput setaf 2)

	# ideally SGR 22;39, or SGR 0
	erry_tput['fo']=$(tput sgr0)

	# TODO: test non-xenl terminal
	if tput xenl
	then erry_tput['wrap']='  '
	else erry_tput['wrap']=' '
	fi
	if ! tput am
	then erry_tput['wrap']=$'\n'
	fi
}

erry_fix_eol() {
	local cuf n=$((COLUMNS > 2 ? COLUMNS - 2 : 1))

	if [[ ${erry_tput['wrap']} == $'\n' ]]
	then cuf=
	elif [[ -n ${erry_tput['cuf']} ]]
	then cuf=${erry_tput['cuf']/'%p1%d'/${n}}
	# no cuf? no problem! just spam spaces
	else cuf=$(printf '%*s' "${n}" '')
	fi

	printf %s "${cuf}${erry_tput['wrap']}${erry_tput['cr']}"
}

erry_show_pipestatus() {
	# save pipestatus first
	local pipestatus=("${PIPESTATUS[@]}")

	local IFS=\| p

	for p in "${!pipestatus[@]}"
	do
		if [[ ${pipestatus[p]} -ne 0 ]]
		then pipestatus[p]=${erry_tput['fR']}${pipestatus[p]}${erry_tput['fo']}
		fi
	done

	printf '%s\n' "${erry_tput['fG']}PIPESTATUS${erry_tput['fo']}=(${pipestatus[*]})"
}

erry_show_pwd() {
	local pwd='\w'
	printf '%s\n' "${erry_tput['fG']}PWD${erry_tput['fo']}=${pwd@P}"
}

erry_show_shlvl() {
	printf '%s\n' "${erry_tput['fG']}SHLVL${erry_tput['fo']}=${SHLVL}"
}

# save on tput calls
erry_gen_tput 2>/dev/null
PROMPT_COMMAND+=(erry_fix_eol)
PROMPT_COMMAND+=(erry_show_pipestatus)
PROMPT_COMMAND+=(erry_show_pwd)
PROMPT_COMMAND+=(erry_show_shlvl)
PS1='\$ '
