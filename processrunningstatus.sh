#!/bin/bash
# File contents - Get all process running for more than four hours
# SV_NAME TK_TASKID TK_DISP_RUNSTATE TK_START_TIME
# ------- --------- ---------------- -------------

# serv1   444596447 Completed 2018-11-05 00:11:10
# serv2   444596446 Completed 2018-11-05 00:05:09
# serv3   444596446 Running   2018-11-05 00:05:09
#
#
line_number=1;
file_path="$1"
echo "Reading file $1"
DATE=$(date +%s)
echo "Current time is : $DATE"
task_ids=""
found=0
while read line; do
   line_number=`expr $line_number + 1`;
   if [ $line_number -gt 3 ]; 
   then
     server=`echo $line | awk '{print $1}'`
     status=`echo $line | awk '{print $3}'`
     date=`echo $line | awk '{print $4}'`
     time=`echo $line | awk '{print $5}'`
     if [[ $time = 'error' ]] || [[ $time = '' ]]
     then
       continue
     fi   
     epoch=`date -j -f "%Y-%m-%d %T" "$date $time" +%s` || continue
     lapsed=`expr $DATE - $epoch`
     if [ $lapsed -gt 3600 ] && [ "Running" = "$status" ]
     then
        found=1
     	taskid=`echo $line | awk '{print $2}'`
     	task_ids="$task_ids $taskid[$server]" 
     	echo "$taskid has been running for more than four hours."
     fi
   fi
done < $file_path
if [[ $found = 1 ]]
then 
 echo "$task_ids are running for more than four hours" | mail -s "a subject" someemail@gmail.com
else
 echo "No running tasks"
fi
