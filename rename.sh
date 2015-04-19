#!/bin/bash
set -o errexit
shopt -s nullglob
shopt -s nocaseglob

# Allow Spaces
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

MYPATH=$1
FILEEXTS=$2

# Avoid overriding same filenames
COUNTER=1
cd $MYPATH

# ./rename myfolder "*.jpg *.png *.foo"
# It doesn't work, it returns all files...
# for i in $(ls $FILEEXTS -rt); do 

# ./rename myfolder jpg,png,foo
# I can't even get this to work from console (on windows)
# Equiv is: ls *.{jpg,png,foo}
# for i in $(ls *.{$FILEEXTS} -rt); do

for i in $(ls *.$FILEEXTS -rt); do
	filename="${i##*/}"
	extension="${filename##*.}"
	filename="${filename%.*}"

    mv "$i" $COUNTER-rename-temp.$extension
    echo "Temped $i to $COUNTER-rename-temp.$extension"
    let COUNTER=COUNTER+1 
done

# Start numbering at 1
COUNTER=1
for j in $(ls *.$FILEEXTS -rt); do
	filename="${j##*/}"
	extension="${filename##*.}"
	filename="${filename%.*}"

	COUNTERSTRING=$(printf %06d.%s ${X%.*} $COUNTER)
    mv "$j" $COUNTERSTRING$extension
    echo "Renamed $j to $COUNTERSTRING$extension"
    let COUNTER=COUNTER+1 
done

# Reset IFS
IFS=$SAVEIFS
