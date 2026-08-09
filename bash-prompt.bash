erry_fix_eol() {
	# '\u21B5' carriage return
	# '\u23CE' return symbol
	printf '\e[1;31m\u21B5\e[m \e[%dC  \r\e[J\r' $((COLUMNS > 4 ? COLUMNS - 4 : 1))
}

erry_set_title_prompt() {
	local title
	title='\w'
	# bash already sanitizes the expansion of \w
	printf '\e]2;%s\e\\\r' "${title@P}"
}

erry_set_title_command() {
	local title oct c0 pc0
	title=${ fc -ln -0; }
	# temp variable make more readable output in declare
	printf -v c0 '\t '
	title=${title#"${c0}"}
	printf -v c0 '\n'
	title=${title%"${c0}"}

	# replace all C0 controls with their printable forms
	for oct in {0..3}{0..7}; do
		printf -v c0 '%b' '\00'"${oct}"
		printf -v pc0 '^%b' '\01'"${oct}"
		title=${title//"${c0}"/${pc0}}
	done
	# and DEL
	printf -v c0 '\177'
	title=${title//"${c0}"/^?}

	# CR syncs column in the terminal and in the kernel's cooked mode
	printf '\e]2;%s\e\\\r' "${title}"
}

erry_show_info() {
	declare -a pipestatus=("${PIPESTATUS[@]}")
	declare -a output
	local IFS p pwd
	pwd='\w'

	for p in "${!pipestatus[@]}"; do
		if [[ ${pipestatus[p]} -ne 0 ]]; then
			printf -v pipestatus[p] '\e[1;31m%s\e[m' "${pipestatus[p]}"
		fi
	done

	IFS='|'
	printf -v output[0] '\e[1;32mPIPESTATUS\e[m=(%s)' "${pipestatus[*]}"
	printf -v output[1] '\e[1;32mPWD\e[m=%s' "${pwd@P}"
	printf -v output[2] '\e[1;32mSHLVL\e[m=%s' "${SHLVL}"
	IFS=' '
	printf '%s\n' "${output[*]}"
}

if [[ ${TERM} != dumb ]]; then
	PROMPT_COMMAND+=(erry_fix_eol)
	PROMPT_COMMAND+=(erry_set_title_prompt)
	PROMPT_COMMAND+=(erry_show_info)
	# shellcheck disable=SC2016
	PS0='${ erry_set_title_command; }'"${PS0:-}"
fi
