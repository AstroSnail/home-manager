erry_gen_tput() {
	declare -Ag erry_tput

	# ideally SGR 1;31
	erry_tput[fR]=$(tput bold)
	erry_tput[fR]+=$(tput setaf 1)

	# ideally SGR 1;32
	erry_tput[fG]=$(tput bold)
	erry_tput[fG]+=$(tput setaf 2)

	# ideally SGR 22;39, or SGR 0
	erry_tput[fo]=$(tput sgr0)

	# parameter left unset, placeholder will be replaced later
	erry_tput[cuf]=$(tput cuf)

	# TODO: test non-xenl terminal
	if ! tput am || [[ ${TERM} == dumb ]]; then
		erry_tput[wrap]=$'\n'
	elif tput xenl; then
		erry_tput[wrap]=$'  \r'
	else
		erry_tput[wrap]=$' \r'
	fi

	# OSC 2 doesn't seem to have a *specific* corresponding terminfo code.
	# However, it's common practice to set tsl/fsl in such a way that the
	# "status line" is actually the window title. TS should be preferred
	# over tsl, since OSC 2 can't set the column. If we have a real status
	# line then that's fine too.
	# Some status lines (e.g. OSC 2) implicitly clear old contents when set.
	# In case they don't, el may be used after tsl if eslok is set,
	# otherwise dsl should be used *before* tsl.
	if tput hs; then
		erry_tput[tsl]=
		if ! tput eslok; then
			erry_tput[tsl]+=$(tput dsl)
		fi
		if ! erry_tput[tsl]+=$(tput TS); then
			erry_tput[tsl]+=$(tput tsl 0)
		fi
		if tput eslok; then
			erry_tput[tsl]+=$(tput el)
		fi
		erry_tput[fsl]=$(tput fsl)
	elif [[ ${TERM} == xterm* ]]; then
		# Annoyingly, xterm terminfo descriptions don't include a
		# status/title line.
		erry_tput[tsl]=$'\e]2;'
		erry_tput[fsl]=$'\e\\'
	else
		erry_tput[tsl]=
		erry_tput[fsl]=
	fi
}

erry_fix_eol() {
	local cuf n
	n=$((COLUMNS > 2 ? COLUMNS - 2 : 1))

	if [[ ${erry_tput[wrap]} == $'\n' ]]; then
		cuf=
	elif [[ -n ${erry_tput[cuf]} ]]; then
		# this is technically wrong, but it works for cuf
		cuf=${erry_tput[cuf]/'%p1%d'/${n}}
	else
		# no cuf? no problem! just spam spaces
		# could use cuf1 if available (non-destructive space)
		# but i don't bother
		printf -v cuf '%*s' "${n}" ''
	fi

	printf %s "${cuf}${erry_tput[wrap]}"
}

erry_show_info() {
	local pipestatus=("${PIPESTATUS[@]}")
	local output=()
	local IFS

	local p
	for p in "${!pipestatus[@]}"; do
		if [[ ${pipestatus[p]} -ne 0 ]]; then
			pipestatus[p]=${erry_tput[fR]}${pipestatus[p]}${erry_tput[fo]}
		fi
	done
	IFS=\|
	output+=("${erry_tput[fG]}PIPESTATUS${erry_tput[fo]}=(${pipestatus[*]})")

	local pwd
	pwd='\w'
	output+=("${erry_tput[fG]}PWD${erry_tput[fo]}=${pwd@P}")

	output+=("${erry_tput[fG]}SHLVL${erry_tput[fo]}=${SHLVL}")

	IFS=' '
	printf '%s\n' "${output[*]}"
}

erry_set_title_prompt() {
	if [[ -n ${erry_tput[tsl]} ]]; then
		local title
		title='\w'
		# bash already sanitizes the expansion of \w
		printf %s "${erry_tput[tsl]}${title@P}${erry_tput[fsl]}"
	fi
}

erry_set_title_command() {
	if [[ -n ${erry_tput[tsl]} ]]; then
		local title
		# title=$(fc -ln -0)
		# hacky trick to avoid slow command substitution
		fc -ln -0 >|"${erry_tmpfile:?}"
		IFS= read -r -d '' title <"${erry_tmpfile}"
		title=${title#$'\t '}
		title=${title%$'\n'}

		# replace all C0 controls with their printable forms
		local oct c0 pc0
		for oct in {0..3}{0..7}; do
			printf -v c0 %b '\00'"${oct}"
			printf -v pc0 %b '\01'"${oct}"
			title=${title//${c0}/^${pc0}}
		done
		# and DEL
		title=${title//$'\177'/^?}

		printf %s "${erry_tput[tsl]}${title}${erry_tput[fsl]}"
	fi
}

# save on tput calls
# if you change TERM you should run this again
erry_gen_tput >/dev/null 2>&1
PROMPT_COMMAND+=(erry_fix_eol)
PROMPT_COMMAND+=(erry_set_title_prompt)
PROMPT_COMMAND+=(erry_show_info)
PS1='\$ '
# shellcheck disable=SC2016
PS0='$(erry_set_title_command)'
