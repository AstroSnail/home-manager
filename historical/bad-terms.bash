# bad terminals with hardcoded and misleading TERM definitions. a
# downside of guessing and patching TERM like this is the possibility
# of ambiguous conditions, so setting TERM in the terminal itself
# should be used if possible.

# vte hardcodes xterm-256color
# https://gitlab.gnome.org/GNOME/vte/-/blob/0.70.6/src/pty.cc#L260
# https://gitlab.gnome.org/GNOME/vte/-/blob/0.70.6/src/spawn.cc#L243
# (can't tell which; environment doesn't affect vte's choice of TERM)
if [[ -n $VTE_VERSION ]]; then
  TERM=''${TERM/#xterm/vte}
fi

# vscode hardcodes xterm-256color
# (seemingly specifically vscode, not xterm.js)
# https://github.com/microsoft/vscode/blob/1.132.0/src/vs/platform/terminal/node/terminalProcess.ts#L154
# TERM=vscode is 256color
if [[ $TERM_PROGRAM == vscode ]]; then
  TERM=''${TERM/#xterm/vscode}
  TERM=''${TERM/%-256color}
fi
