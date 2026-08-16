# this is the server
# on the client run:
#   pactl load-module module-native-protocol-tcp listen=::1 auth-anonymous=true
#   ssh -L '[::1]:5900:[::1]:5900' -R '[::1]:4713:[::1]:4713'

fps=${1:-12}

# FIXME: sleep and guessing WAYLAND_DISPLAY is bad :(
# startx had a similar problem, how was it solved?
# TODO: try waiting on sway session target
WLR_BACKENDS=headless WLR_LIBINPUT_NO_DEVICES=1 \
</dev/null >|~/.local/share/sway-headless-o.txt 2>|~/.local/share/sway-headless-e.txt \
sway &

sleep 1

WAYLAND_DISPLAY=wayland-1 \
</dev/null >|~/.local/share/wayvnc-o.txt 2>|~/.local/share/wayvnc-e.txt \
wayvnc --max-fps="${fps}" &

erry_pulse_tunnel=$(pactl load-module module-tunnel-sink server=::1)
erry_pulse_exit() {
	pactl unload-module "${erry_pulse_tunnel}"
}
trap erry_pulse_exit EXIT
