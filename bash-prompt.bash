# CSI 0 doesn't seem to have a corresponding terminfo code
erry_set_title() {
	printf '\e]0;%s\e\\' "${1}"
}

erry_set_title_sanitize() (
	title=${1}

	# replace all C0 controls with their printable forms
	for fmt in {0..3}{0..7}
	do
		printf -v c0 '%b' '\00'"${fmt}"
		printf -v pc0 '^%b' '\01'"${fmt}"
		title=${title//${c0}/${pc0}}
	done

	erry_set_title "${title}"
)

# evaluated in subshell (command substitution)
erry_show_pipestatus() {
	for p in "${!erry_pipestatus[@]}"
	do
		if [[ ${erry_pipestatus[p]} -ne 0 ]]
		then
			this_status=
			this_status+=$(tput bold)
			this_status+=$(tput setaf 1)
			this_status+=${erry_pipestatus[p]}
			this_status+=$(tput sgr0)
			erry_pipestatus[p]=${this_status}
		fi
	done
	IFS=\|
	printf %s "${erry_pipestatus[*]}"
}

erry_gen_prompt_extra() {
	# TODO: detect whether cursor is on the first column
	# might use fish's trick: print ↵ or ⏎, then as many
	# spaces as $COLUMNS - 1, then \r
	# tip: stty size
	# maybe optimize spaces-spam with cuf. but beware of xenl!
	# or maybe use terminfo u6/u7, however:
	# - TODO: how to parse u6
	# - how to deal with previously-unread stdin? discard?
	#   (probably a good idea, but needs
	#   care in case terminal doesn't respond)
	printf '\n'

	tput -S <<-'!'
		sgr0
		bold
		setaf 2
	!
	printf PIPESTATUS
	tput sgr0
	printf '=($(erry_show_pipestatus))\n'

	# bash already sanitizes the expansion of \w
	erry_set_title '\w'
	tput -S <<-'!'
		bold
		setaf 2
	!
	printf PWD
	tput sgr0
	printf '=\\w\n'

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

erry_prompt_extra=$(erry_gen_prompt_extra)
erry_prompt_extra=${erry_prompt_extra%.}

erry_show_prompt_extra() (
	# we don't need to restore $? as long as the command
	# gets its own place in the $PROMPT_COMMAND array
	erry_pipestatus=("${PIPESTATUS[@]}")
	printf %s "${erry_prompt_extra@P}"
)

if [[ ${TERM} != dumb ]]
then
	PROMPT_COMMAND+=(erry_show_prompt_extra)
	PS1='\$ '

	# PS0 doesn't get an up-to-date BASH_COMMAND :<
	# DEBUG trap will have to do
	# TODO: append to trap
	if [[ -n $(trap -p DEBUG) ]]
	then printf 'DEBUG trap conflict!\n' >&2
	fi
	trap 'erry_set_title_sanitize "${BASH_COMMAND}"' DEBUG
fi
