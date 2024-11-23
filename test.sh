#!/bin/bash

green () {
	echo -n "[1;32m$1[0m"
}

blue () {
	echo -n "[1;34m$1[0m"
}

STATUS=0

green "                Testing" && echo
green "---------------------------------------------" && echo
echo

while IFS= read -r line; do
	output=`echo "$line" | ./times`

	if [[ -z "$output" ]]; then
		output="[1;31mERROR[0m"
		STATUS=1
	fi

	if [[ ! $output =~ [0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
		output="$output [1;31mERROR[0m"
		STATUS=1
	fi

	blue " * "
	printf "%47s --> %s\n" "$line" "$output"
done < date_formats.txt

exit $STATUS
