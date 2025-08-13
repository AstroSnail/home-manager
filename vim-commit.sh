vim-drop "$1"
printf 'Type y <enter> after saving the commit message. '
read -r resp
if [ "${resp}" = y ]
then exit 0
else exit 1
fi
