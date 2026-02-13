filename=$1
case ${filename} in
	(/*) filepath=${filename};;
	(*) filepath=${PWD}/${filename};;
esac
filejson=$(jq --raw-input --slurp 'rtrimstr("\n")' <<EOF
${filepath}
EOF
)
# shellcheck disable=SC1003
printf '\e]51;["drop", %s]\e\\' "${filejson}"
