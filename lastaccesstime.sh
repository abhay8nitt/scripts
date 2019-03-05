#!/bin/bash
# The script detects for the last file access time and emails the time and the user to the specieifed email 
# Usage ./lastaccesstime.sh <file_to_stat> <last_access_time_file> <email> <sleep_duration>
filename=$1
lat_file=$2
echo "Stat $filename"
if [ ! -f $lat_file ]; then
   echo "File <$lat_file> not found!"
   #lastaccesstime=`stat -x $filename | grep "Access:" | awk '{$1="";print $0}' | xargs `
   lastaccesstime=`stat --printf="%x" $filename`
else
   lastaccesstime=`cat $lat_file | xargs`
fi
echo "Last access time of the file $filename: $lastaccesstime"
last_unix=`date -d "$lastaccesstime" "+%s"`
echo $last_unix
while :
do
 echo "Press [CTRL+C] to stop.."
 #accesstime=`stat -x $filename | grep "Access:" | awk '{$1="";print $0}' | xargs `
 accesstime=`stat --printf="%x" $filename`
 curr_unix=`date -d "$accesstime" "+%s"`
 if [ $last_unix -ne $curr_unix ]; then
   echo "$filename access time changed: $accesstime by user: `stat -c '%U' $filename`" |  mail -s "Last Access time" $3
   lastaccesstime=$accesstime
   last_unix=$curr_unix
   rm -rf $lat_file
   echo $lastaccesstime > $lat_file
 fi
 sleep $4
done
