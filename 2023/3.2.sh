#!/bin/bash

declare -a lines
declare -Ai nums probablyGears

mapfile -t lines

for line in "${lines[@]}"; do
	declare -i l=-1 r=0
	while read -rN1 ch; do
		if [[ $ch =~ ^[0-9]$ ]]; then
			((l > -1 || (l = r)))
			num+="$ch"
		elif [[ -n $num ]]; then
			nums["$((n))~$((l))~$((r - l))"]=$num
			unset num
			let l=-1
		fi
		if [[ $ch == "*" ]]; then
			probablyGears["$((n))~$((r))"]=1
		fi
		let r++
	done <<< "$line"
	let n++
done

printf '%s\n' "${!probablyGears[@]}" \
	| sort -n \
	| while IFS='~' read -r n l; do
		printf '%s\n' "${!nums[@]}" \
			| grep -E "^($((n - 1))|$n|$((n + 1)))~" \
			| while IFS='~' read -r N L R; do
				((L <= l && l <= L + R || l + 1 == L)) && echo "${nums["$N~$L~$R"]}"
			done | xargs | grep -xE '[0-9]+ [0-9]+' | tr ' ' '*'
	done
