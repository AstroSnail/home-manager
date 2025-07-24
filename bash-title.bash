# OSC 2 doesn't seem to have a *specific* corresponding terminfo code.
# however it's common practice to set tsl/fsl in such a way that the
# "status line" is actually the window title.
# TS should be preferred over tsl, since OSC 2 can't set the column.
erry_set_title() {
	printf '\e]2;%s\e\\' "${1}"
}

erry_set_title_sanitize() {
	local title oct c0 pc0

	title=${1}

	# replace all C0 controls with their printable forms
	for oct in {0..3}{0..7}
	do
		printf -v c0 '%b' '\00'"${oct}"
		printf -v pc0 '%b' '\01'"${oct}"
		title=${title//${c0}/^${pc0}}
	done
	# and DEL
	title=${title//$'\177'/^?}

	erry_set_title "${title}"
}

erry_show_prompt_title() {
	printf %s "${erry_prompt_title@P}"
}

if [[ ${TERM} != dumb ]]
then
	# bash already sanitizes the expansion of \w
	erry_prompt_title=$(erry_set_title '\w')

	PROMPT_COMMAND+=(erry_show_prompt_title)

	# PS0 doesn't get an up-to-date BASH_COMMAND :<
	# DEBUG trap will have to do
	# TODO: append to trap
	if [[ -n $(trap -p DEBUG) ]]
	then printf 'DEBUG trap conflict!\n' >&2
	fi
	trap 'erry_set_title_sanitize "${BASH_COMMAND}"' DEBUG
fi
