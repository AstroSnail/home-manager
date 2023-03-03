doom=${HOME}/.emacs.d/bin/doom

if [ $# -gt 0 ]
then exec "${doom}" "$@"
else
	"${doom}" sync
	exec "${doom}" run
fi
