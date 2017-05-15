#!/bin/ksh

echo "Please specify File name for consolidated ldt file"
read consol_file_name

echo "APPS Schema Password: "
read APPS_PASS

while read line
do

appl_name=`echo $line | cut -d"," -f1`
prog_name=`echo $line | cut -d"," -f2`
FNDLOAD apps/$APPS_PASS O Y DOWNLOAD $FND_TOP/patch/115/import/afcpprog.lct $prog_name'.ldt' PROGRAM APPLICATION_SHORT_NAME="$appl_name" CONCURRENT_PROGRAM_NAME="$prog_name"
done < $1


for file in `ls *ldt`
do
echo  $file
    sed -n '1,/END VALUE_SET/p' $file > $consol_file_name'.ldt'
break
done

for file in `ls *ldt`
do
echo $file
sed '1,/END VALUE_SET/d' $file >> $consol_file_name'.ldt'
done



