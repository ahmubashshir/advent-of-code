#!/bin/bash
#exec cat

declare -a lines
declare -i x
declare -Ai nums
mapfile -t lines
for line in "${lines[@]}"; do
	declare -i l=-1 r=0
	while read -rN1 ch; do
		#set -x
		if [[ $ch =~ ^[0-9]$ ]]; then
			((l > -1 || (l = r)))
			num+="$ch"
		elif [[ -n $num ]]; then
			nums["$((n))~$((l))~$((r - l))"]=$num
			unset num
			let l=-1
		fi
		let r++
		#set +x
	done <<< "$line"
	let n++
done
let x=${#lines[@]}-1
printf '%s\n' "${!nums[@]}" \
	| sort -n \
	| while IFS='~' IFS='~' read -r n l r line; do
		line+="${lines[n]:(l - 1):1}${lines[n]:(l + r):1}"
		((n == 0)) || line+="${lines[n - 1]:(l - (l > 0)):(r + 1 + (l > 0))}"
		((n == x)) || line+="${lines[n + 1]:(l - (l > 0)):(r + 1 + (l > 0))}"
		! [[ $line =~ [^0-9.] ]] || echo ${lines[n]:l:r}
	done
