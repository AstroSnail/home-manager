filename=$1
case ${filename} in
	(/*) filepath=${filename};;
	(*) filepath=${PWD}/${filename};;
esac
# TODO: escape special characters
# shellcheck disable=SC1003
printf '\e]51;["drop", "%s"]\e\\' "${filepath}"
