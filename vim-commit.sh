filename=$1
# trust that filename doesn't need to be escaped
# (i expect it to always be .git/COMMIT_EDITMSG or something like that)
printf '\e]51;["drop", "%s"]\e\\Type y <enter> after saving the commit message. ' "${filename}"
read -r resp
if [ "${resp}" = y ]
then exit 0
else exit 1
fi
