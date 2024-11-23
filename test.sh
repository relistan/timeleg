#!/bin/bash

green () {
	echo -n "[1;32m$1[0m"
}

blue () {
	echo -n "[1;34m$1[0m"
}

red () {
	echo -n "[1;31m$1[0m"
}

STATUS=0

blue "                                ---------------------------------------------" && echo
blue "                                                Testing" && echo
blue "                                ---------------------------------------------" && echo
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

	if [[ $STATUS -eq 0 ]]; then
		output=`printf "%-30s %s" "$output" "[1;32mOK[0m"`
	fi

	blue " * "
	printf "%47s --> %s\n" "$line" "$output"
done < date_formats.txt

if [[ $STATUS -eq 0 ]]; then
	green "                                ---------------------------------------------" && echo
	green "                                [1;32mAll tests passed[0m" && echo
	green "                                ---------------------------------------------" && echo
else
	red "                                ---------------------------------------------" && echo
	red "                                [1;31mSome tests failed[0m" && echo
	red "                                ---------------------------------------------" && echo
fi

exit $STATUS
