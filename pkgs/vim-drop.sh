for filename do
	case ${filename} in
		(/*) filepath=${filename};;
		(*) filepath=${PWD}/${filename};;
	esac
	filejson=$(jq --raw-input --slurp 'rtrimstr("\n")' <<-EOF
	${filepath}
	EOF
	)
	printf '\e]51;["drop", %s]\e\\\r' "${filejson}"
done
