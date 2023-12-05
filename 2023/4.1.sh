#!/bin/bash
declare -gA nwin
declare -gi my=0 cnt=0
declare -gi nums

while IFS=: read -r game num; do
	tr ' ' '\n' <<< "$num @@" \
		| while read -r in; do
			if [[ $in == '|' ]]; then
				my=1
			elif [[ $in == @@ && $cnt -gt 0 ]]; then
				echo "2^$((cnt - 1))"
			elif [[ ${nwin["~$in"]} ]]; then
				let cnt++
			elif [[ $my == 0 && $in ]]; then
				nwin["~$in"]=1
			fi
		done
done
