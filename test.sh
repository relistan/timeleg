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

# Overall test status
STATUS=0
FAILCOUNT=0

blue "                                ---------------------------------------------" && echo
blue "                                                Testing" && echo
blue "                                ---------------------------------------------" && echo
echo

while IFS= read -r line; do
	# Break out the marker
	test_type=`echo $line | awk -F@ '{print $1}'`
	line=`echo $line | awk -F'@ ' '{print $2}'`

	# Run the test
	output=`echo "$line" | ./times`

	# Job status for each test
	job_status=0

	if [[ -z "$output" ]]; then
		output="[1;31mERROR[0m"
		STATUS=1
	fi

	case $test_type in
		date)
			if [[ ! $output =~ [0-9]{4}-[0-9]{2}-[0-9]{2} ]]; then
				output=`printf "%-30s %s" "$output" "[1;31mERROR[0m"`
				job_status=1
			fi
			;;
		datetime)
			if [[ ! $output =~ [0-9]{4}-[0-9]{2}-[0-9]{2}\ [0-9]{2}:[0-9]{2}:[0-9]{2} ]]; then
				output=`printf "%-30s %s" "$output" "[1;31mERROR[0m"`
				job_status=1
			fi
			;;
		datetimetz)
			if [[ ! $output =~ [0-9]{2}:[0-9]{2}:[0-9]{2} ]]; then
				output=`printf "%-30s %s" "$output" "[1;31mERROR[0m"`
				job_status=1
			fi
			;;
			
		*)
			output="$output [1;31mERROR[0m"
			job_status=1
			;;
	esac

	if [[ $job_status -eq 0 ]]; then
		output=`printf "%-30s %s" "$output" "[1;32mOK[0m"`
	fi

	if [[ $job_status -eq 1 ]]; then
		STATUS=1
		FAILCOUNT=$((FAILCOUNT+1))
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
	red "                                [1;31m$FAILCOUNT tests failed[0m" && echo
	red "                                ---------------------------------------------" && echo
fi

exit $STATUS
