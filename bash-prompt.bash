erry_caretify() {
	# convert C0 control characters (and DEL) to caret notation.
	# expected to be used like ${| REPLY=${input}; erry_caretify; }
	local oct c0 pc0
	# this loop alone takes over 200 microseconds! even if input is short
	for oct in {0..3}{0..7}; do
		printf -v c0 '%b' '\00'"${oct}"
		printf -v pc0 '^%b' '\01'"${oct}"
		REPLY=${REPLY//"${c0}"/${pc0}}
	done
	# bash expands $'...' in declare -f output, which is ugly
	# so i don't use it
	printf -v c0 '\177'
	REPLY=${REPLY//"${c0}"/^?}
}

erry_prompt_command() {
	# (1) if we're not at the beginning of the line (for example, the
	# previous command printed its last line without eol, or ended with an
	# echoed-out ^C) then move to the beginning of the next:
	# (a) reset all text and color attributes;
	# (b) print one of these symbols in bright red for flavour;
	#     - '\u21B5' carriage return
	#     - '\u23CE' return symbol
	# (c) print a space to avoid later spaces eating the symbol if it was
	#     placed exactly at the right margin, due to xenl;
	# (d) move cursor forward enough times so that, had it really been at
	#     the beginning of the line before, it's one cell short of the
	#     right margin after;
	# (e) print two spaces to force wrapping if cursor is at the right
	#     margin, due to xenl;
	# (f) return to beginning of line.
	#
	# (2) usually, this leaves the cursor at the beginning of an empty
	# line, possibly ontop of the symbol we printed earlier. on the off
	# chance that the screen was more trashed than that, clear all lines at
	# and below the cursor to make way for the rest of the prompt.
	#
	# (3) next, set the terminal window title to the cwd (specifically
	# bash's prompt-expansion of \w, which is modified by PROMPT_DIRTRIM
	# and already sanitized of control characters).
	#
	# (4) finally, print useful user info before the primary prompt.

	# saving PIPESTATUS must come first
	declare -a pipestatus=("${PIPESTATUS[@]}") info
	local IFS cwd='\w' p

	for p in "${!pipestatus[@]}"; do
		if [[ ${pipestatus[p]} -ne 0 ]]; then
			printf -v pipestatus[p] '\e[1;31m%s\e[m' \
				"${pipestatus[p]}"
		fi
	done

	# TODO: DIRSTACK? history number?
	IFS='|'
	printf -v info[0] '\e[1;32mPIPESTATUS\e[m=(%s)' "${pipestatus[*]}"
	printf -v info[1] '\e[1;32mPWD\e[m=%s' "${cwd@P}"
	printf -v info[2] '\e[1;32mSHLVL\e[m=%s' "${SHLVL}"

	IFS=' '
	#       1  a     b         cd     e f 2   3          4
	printf '\e[;1;31m\u21B5\e[m \e[%dC  \r\e[J\e]2;%s\e\\%s\n' \
		$((COLUMNS > 4 ? COLUMNS - 4 : 1)) "${cwd@P}" "${info[*]}"
}

erry_ps0() {
	# set the terminal window title to the command just entered.
	# BASH_COMMAND isn't updated in time for PS0, so list it from fc
	# instead and massage its output. it prints control characters
	# verbatim, so we sanitize it ourselves.
	# TODO: fc can't see commands excluded from history by HISTCONTROL or
	# HISTIGNORE. what then?
	local cmd
	cmd=${ fc -ln -0; }
	# tab space
	cmd=${cmd#'	 '}
	cmd=${| REPLY=${cmd}; erry_caretify; }
	# CR syncs column in the terminal and in the kernel's cooked mode
	printf '\e]2;%s\e\\\r' "${cmd}"
}

if [[ ${TERM} != dumb ]]; then
	PROMPT_COMMAND+=(erry_prompt_command)
	# shellcheck disable=SC2016
	PS0='${ erry_ps0; }'"${PS0:-}"
fi
