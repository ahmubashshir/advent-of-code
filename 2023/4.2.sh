#!/bin/bash
declare -gai nums card

while IFS=: read -r _ num; do
	declare -i my=0 cnt=0
	declare -A nwin=()

	tr ' ' '\n' <<< "$num @@" \
		| while read -r in; do
			if [[ $in == '|' ]]; then
				my=1
			elif [[ $in == @@ ]]; then
				echo "$cnt"
			elif [[ ${nwin["~$in"]} ]]; then
				((cnt++))
			elif [[ $my == 0 && $in ]]; then
				nwin["~$in"]=1
			fi
		done
done | xargs -0 printf '%s@@\n' \
	| while read -r num; do
		if [[ $num != '@@' ]]; then
			nums+=("$num")
			card+=(1)
			continue
		fi
		for ((i = 0; i < ${#nums[@]}; i++)); do
			for ((j = 1; j < nums[i] + 1; j++)); do
				((card[i + j] += card[i]))
			done
		done
		printf '%s\n' "${card[@]}"
	done
