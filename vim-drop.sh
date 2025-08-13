filename=$1
case ${filename} in
	(/*) filepath=${filename};;
	(*) filepath=${PWD}/${filename};;
esac
filejson=$(printf %s "${filepath}" | jq --raw-input --slurp)
# shellcheck disable=SC1003
printf '\e]51;["drop", %s]\e\\' "${filejson}"
