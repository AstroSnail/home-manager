remote=${1:?}
savefile=${2:?}

date=$(date --iso-8601=seconds --utc)
ip=$(ssh -- "${remote}" printf %s '"${SSH_CLIENT}"')
ip=${ip%% *}

printf '%s %s\n' "${date}" "${ip}" >>"${savefile}"
