function kv(key, val) {
	return sprintf("\"%s\":\"%s\"", key, val)
}

function runcommand(cmd, colorfn,    out, rout) {
	rout = cmd | getline out
	close(cmd)
	if (rout != 1) {
		return ""
	}
	return ( \
		"{" kv("name", "runcommand") \
		"," kv("instance", cmd) \
		"," kv("color", @colorfn(out)) \
		"," kv("full_text", (cmd ": " out)) \
		"," kv("short_text", out) \
		"}," \
	)
}

function systemctl_color(state) {
	switch (state) {
	case "running":
		return "#00FF00"
	case "degraded":
		return "#FF0000"
	default:
		return "#FFFF00"
	}
}

function runcommands() {
	return ( \
		runcommand("systemctl is-system-running", "systemctl_color") \
		runcommand("systemctl --user is-system-running", "systemctl_color") \
	)
}

NR >= 3 {
	match($0, /^(,?)\[(.*)]$/, arr)
	$0 = sprintf("%s[%s%s]", arr[1], runcommands(), arr[2])
}

{
	print
	fflush()
}
