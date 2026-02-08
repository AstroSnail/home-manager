# shellcheck disable=SC1003

# OSC 2 doesn't seem to have a *specific* corresponding terminfo code. However,
# it's common practice to set tsl/fsl in such a way that the "status line" is
# actually the window title. TS should be preferred over tsl, since OSC 2 can't
# set the column and it implicitly clears the old contents.
# Annoyingly, xterm terminfo descriptions don't include either.
erry_set_title() {
	printf '\e]2;%s\e\\' "${1}"
}

erry_visual_escape() {
	local output oct c0 pc0
	output=${1}

	# replace all C0 controls with their printable forms
	for oct in {0..3}{0..7}; do
		printf -v c0 %b '\00'"${oct}"
		printf -v pc0 %b '\01'"${oct}"
		output=${output//${c0}/^${pc0}}
	done
	# and DEL
	output=${output//$'\177'/^?}

	printf %s "${output}"
}

erry_show_prompt_title() {
	# bash already sanitizes the expansion of \w
	local title
	title='\w'
	erry_set_title "${title@P}"
}

erry_show_command_title() {
	local title
	title=$(erry_visual_escape "${BASH_COMMAND}")
	erry_set_title "${title}"
}

if [[ ${TERM} == xterm* ]]; then
	PROMPT_COMMAND+=(erry_show_prompt_title)

	# PS0 doesn't get an up-to-date BASH_COMMAND :<
	# DEBUG trap will have to do
	# TODO: append to trap
	# TODO: does this check actually even work?
	if [[ -n $(trap -p DEBUG) ]]; then
		printf 'DEBUG trap conflict!\n' >&2
	fi
	trap 'erry_show_command_title' DEBUG
fi
