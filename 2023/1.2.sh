#!/bin/sh
sed -nE \
	-e 's/zero/0o/g' \
	-e 's/one/o1e/g' \
	-e 's/two/t2o/g' \
	-e 's/three/t3e/g' \
	-e 's/four/4/g' \
	-e 's/five/5e/g' \
	-e 's/six/6/g' \
	-e 's/seven/7n/g' \
	-e 's/eight/e8t/g' \
	-e 's/nine/n9e/g' \
	-e 's/[^0-9]//g' \
	-e '/.{2,}/s/^(.).*(.)$/\1\2/p' \
	-e '/^.$/s/./\0\0/p'
