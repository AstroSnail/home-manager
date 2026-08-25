caretify_quick() {
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

whichpath() {
	local arg
	for arg do
		arg=${ type -P -- "${arg}"; }
		realpath -- "${arg}"
	done
}
