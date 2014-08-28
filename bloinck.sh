#!/bin/bash

debug() {
	[ -n "$DEBUG" ] && echo "$*"
}

# SUM
sum_cmd() {
	sha256sum | tr -d ' -'
}
SUM_EMPTY="$(dd if=/dev/null | sum_cmd)"

# PAD
PAD="000000000"

# In Megabytes
MAX_BLOCK_SIZE="9"
MIN_BLOCK_SIZE="1"

DEV="$1"
DEV_NICE_NAME="${DEV//\//-}"

DEST="backup"
TODAY="$(date +%Y-%m-%d__%H-%M-%S)"

PREFIX="$DEST/$DEV_NICE_NAME"


SIZE="$MAX_BLOCK_SIZE"




mkdir -p "$PREFIX/$TODAY"
BLOCK=0
SUM=""
while [ "$SUM" != "$SUM_EMPTY" ]; do

	BLOCK_PAD="${PAD:${#BLOCK}}""$BLOCK"

	debug "$BLOCK_PAD"
	SUM="$(dd status=noxfer if="$DEV" bs="$SIZE""M" count=1 skip="$BLOCK" 2> /dev/null | sum_cmd )"
	
	LZ="$PREFIX/$TODAY/$BLOCK_PAD""_""$SUM"".lz"
	
	LAST="$(ls -1t "$PREFIX"/*/"$BLOCK_PAD""_""$SUM"".lz" 2> /dev/null | head -1)"
	if [ -n "$LAST" ]; then
		ln "$LAST" "$LZ"
	else
		dd status=noxfer if="$DEV" bs="$SIZE""M" count=1 skip="$BLOCK" 2> /dev/null |\
			plzip -c |\
			dd status=noxfer of="$LZ" bs=5M 2> /dev/null
	fi
	

	(( BLOCK ++ ))
done

