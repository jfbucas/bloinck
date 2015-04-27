#!/bin/bash

# Local config
if [ -f "./config" ]; then
	. ./config
fi

# Parameters
ALL_HOSTS=""
while [ -n "$1" ]; do
	case "$1" in
		"-g" | "--group" )
			list="$(eval echo \$group_$2)"
			if [ -z "$list" ]; then
				echo "Group $2 is not defined. Please look into your config file"
				exit 1
			fi
			ALL_HOSTS="$ALL_HOSTS ""$list"
			shift
			;;
		* )
			ALL_HOSTS="$ALL_HOSTS ""$1"
			;;
	esac
	shift
done


for HOST in $ALL_HOSTS; do
	for DEVICE in $HOST/*; do
		if [ -d "$DEVICE" ]; then
			du -sh $DEVICE
			du -lsh $DEVICE
			du -sh $DEVICE/*
			du -shl $DEVICE/*
		fi
	done
done
