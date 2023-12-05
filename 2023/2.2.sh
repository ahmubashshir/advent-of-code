#!/bin/sh
while IFS=': ' read -r _ id input; do
	(echo "$input" | sed -E 's/\; ?/\n/g' | while read -r inputs; do
		echo "$inputs" | sed -E 's/, ?/\n/g' | while read -r n c;do
			case "${c:0:1}" in
				(r) echo "$n.0.0";;
				(g) echo "0.$n.0";;
				(b) echo "0.0.$n";;
			esac
		done
	done; echo --) | while IFS=. read -r r g b; do
		if test "x$r" = "x--"; then
			echo "$R*$G*$B"
			break
		fi
		test "$r" -le "${R:-0}" || R=$r
		test "$g" -le "${G:-0}" || G=$g
		test "$b" -le "${B:-0}" || B=$b
	done
done
