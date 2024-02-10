shopt -s nullglob globstar

sleep=0
if [[ "$1" = "--wait" ]]
then
  shift
  sleep=$1
  shift
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "${prefix}"/**/*.gpg )
password_files=( "${password_files[@]#"${prefix}"/}" )
password_files=( "${password_files[@]%.gpg}" )

password_file=$(printf '%s\n' "${password_files[@]}" | dmenu "$@")

[[ -n "${password_file}" ]] || exit

password=$(pass show "${password_file}")
password=${password%%$'\n'*}

sleep "${sleep}"

printf %s "${password}" | xdotool type --clearmodifiers --file -
