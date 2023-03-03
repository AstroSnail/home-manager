case $(basename "$0") in
	(winelegacy)
		export WINEARCH=win32
		export WINEPREFIX="${HOME}/.local/share/winelegacy"
		;;
	(wine32)
		export WINEARCH=win32
		export WINEPREFIX="${HOME}/.local/share/wine32"
		;;
	(wine64)
		export WINEARCH=win64
		export WINEPREFIX="${HOME}/.local/share/wine64"
		;;
	(*)
		echo wtf
		exit 1
		;;
esac

case $1 in
	(exec)
		shift
		exec "$@"
		;;
	(*)
		exec wine "$@"
		;;
esac
