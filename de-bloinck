#!/bin/bash

debug() {
	[ -n "$DEBUG" ] && echo "$*"
}

DEST="backup"
DEV="$1"
DEV_NICE_NAME="${DEV//\//-}"
WHEN=$2
PREFIX="$DEST/$DEV_NICE_NAME"

if [ ! -d "$PREFIX/$WHEN" ]; then
	echo "Cannot de-bloinck un-existing snapshot"
	exit 1
fi


for BLOCK_FILE in $PREFIX/$WHEN/*; do

	dd status=noxfer if="$BLOCK_FILE" bs=5M 2> /dev/null |\
		plzip -d -c
done

