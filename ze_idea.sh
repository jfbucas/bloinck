#!/bin/bash

# In Megabytes
MAX_BLOCK_SIZE="10"
MIN_BLOCK_SIZE="1"

DEV="$1"
DEV_NICE_NAME="${DEV//\//_}"

DEST_FOLDER="backup"

TODAY="$(date +%Y-%m-%d)"

SIZE="$MAX_BLOCK_SIZE"

EMPTY="da39a3ee5e6b4b0d3255bfef95601890afd80709"

while 
dd if="$DEV" bs="$SIZE""M" count=1 | tee >(sha1sum > /tmp/sha1sum) | plzip -c | tee >(sha1sum > /tmp/plzip_sha1sum) | dd of=/dev/null bs=50M

