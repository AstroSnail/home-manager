printf 'Type y <enter> here after saving your changes.\n'
vim-drop "$@"
read -r resp
if [ "${resp}" = y ]; then
	exit 0
else
	exit 1
fi
