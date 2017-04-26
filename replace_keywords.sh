#!/bin/ksh
echo $#
if [ $# -ne 2 ] 
then
    echo "Please specify two parameters"
    echo "First parameter should be a file with keyword replacement for File name"
    echo "Second parameter should be a file with keyword replacement for File Content"
exit 1
fi

if [ ! -f $1 ]
then
    echo "Please check that "$1" exists in current directory"
    exit 1
fi

if [ ! -f $2 ]
then 
    echo "Please check that "$2" exists in current directory"
    exit 1
fi

if [ ! -d source ] || [ ! -d destination ]
then
   echo "Please make sure that 'source' and 'destination' directory exists in current path"
exit 1
fi


filename_sed=`echo $1 | cut -d"." -f1`".sed"
echo $filename_sed
echo $2
datafilename_sed=`echo $2 | cut -d"." -f1`".sed"
echo $datafilename_sed

sed 's/^/s\//g
     s/,/\//g
     s/$/\/\g/g' $1 > $filename_sed

sed 's/^/s\//g
     s/,/\//g
     s/$/\/\g/g' $2 > $datafilename_sed

for file in `ls -1 source`
do
  destination_file=`echo $file | sed -f $filename_sed`
  
  sed -f $datafilename_sed source/$file > destination/$destination_file
done

