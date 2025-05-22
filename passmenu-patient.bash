shopt -s nullglob globstar

typeit=0
if [[ "$1" == "--type" ]]
then
  typeit=1
  shift
fi

sleep=0
if [[ "$1" == "--wait" ]]
then
  shift
  sleep=$1
  shift
fi

if [[ -n "${WAYLAND_DISPLAY-}" ]]
then xdotool="ydotool type --file /dev/stdin"
elif [[ -n "${DISPLAY-}" ]]
then xdotool="xdotool type --clearmodifiers --file -"
else
  echo "Error: No Wayland or X11 display detected" >&2
  exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "${prefix}"/**/*.gpg )
password_files=( "${password_files[@]#"${prefix}"/}" )
password_files=( "${password_files[@]%.gpg}" )

if [[ -z "${password_file-}" ]]
then password_file=$(printf '%s\n' "${password_files[@]}" | dmenu "$@")
fi

[[ -n "${password_file}" ]] || exit

password=$(pass show "${password_file}")
password=${password%%$'\n'*}

sleep "${sleep}"

if [[ "${typeit}" -eq 0 ]]
then
  echo "Error: only --type is supported" >&2
  exit 1
else
  printf %s "${password}" | ${xdotool}
fi
