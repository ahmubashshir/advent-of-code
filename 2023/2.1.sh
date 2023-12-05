#!/bin/sh
declare R=12 G=13 B=14
while IFS=': ' read -r _ id input; do
	echo "$input" | sed -E 's/\; ?/\n/g' | while read -r inputs; do
		echo "$inputs" | sed -E 's/, ?/\n/g' | while read -r n c;do
			case "${c:0:1}" in
				(r) test $n -le $R;;
				(g) test $n -le $G;;
				(b) test $n -le $B;;
			esac || exit 1
		done || exit 1
	done && echo "$id"
done
