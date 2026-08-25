case ${TERM%%-*} in
	(vim)
		# edit in the enclosing vim editor
		# uses terminal-api to spawn a window for each file
		alias vim=vim-drop
		# wait until editing is done
		export EDITOR=vim-edit
		;;
	(*)
		export EDITOR=vim
		;;
esac
