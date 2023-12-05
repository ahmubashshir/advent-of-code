#!/bin/sh
sed -nE \
	-e 's/[^0-9]//g' \
	-e '/.{2,}/s/^(.).*(.)$/\1\2/p' \
	-e '/^.$/s/./\0\0/p'
