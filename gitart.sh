#!/bin/sh

# This should be run as root as we mess with system time
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Parse arguments
if [[ "$#" -ne 1 ]]; then
	echo "Usage: gitart.sh INPUT_FILE"
	exit
fi

IFS=$'\n' input=($(cat "$1"))

name="${input[7]}"
username="${input[8]}"
email="${input[9]}"
repo="${input[10]}"
startdate="${input[11]}"


# Repo configuration
mkdir "$repo"
cd "$repo"
git init -q
git config user.name "$username"
git config user.email "$email"
git remote add origin "https://github.com/$username/$repo.git"

# Input preparation
max=0
for (( i = 0; i < 7; i++ )); do
	if [ "${#input[i]}" -gt "$max" ]; then
		max="${#input[i]}"
	fi
done
width=$(($max-1))
height=7


# Action!

# Save current date
date +%s > ../saved_date

date="$(date +%s -d "$startdate")"
date=$(($date + 43200))
date -s @"${date}" > /dev/null
touch file

for (( i = 0; i < width; i++ )); do
	for (( j = 0; j < height; j++ )); do
		char="${input[j]:i:1}"
		if [ -n "${char}" ] && [ "${char}" != ' ' ]; then
			echo . >> file
			git add file
			git commit -m "." -q
		fi
		date=$(($date + 86400))
		date -s @"${date}" > /dev/null
	done
done

# Restore date
date -s @"$(cat ../saved_date)" > /dev/null
rm ../saved_date

# Push that shit!
git push -u origin master > /dev/null

cd ..
