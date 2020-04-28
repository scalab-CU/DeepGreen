#!/bin/bash

#usage error
if [ $# -ne 2 ]; then
  echo "Usage: "$0" [slurm out file] [sysmon dir]"
fi

#grab information for naming output
if tac $1 | grep -m1 "Hostname:" && tac $1 | grep -m1 "Benchmark\ Test:"; then
  HOST_NAME=`tac $1 | grep -m1 "Hostname:" | awk -F ' ' '{print $2}'`
  JOB_NAME=`tac $1 | grep -m1 "Benchmark\ Test:" | awk -F ' ' '{print $3}'`
  if grep "cpupower\ frequency-set\ -f" $1; then
    FREQ=`grep "cpupower\ frequency-set\ -f" $1 | awk -F ' ' '{print $6}'`
    FREQS_OUT=$HOST_NAME"_"$JOB_NAME"_"$FREQ"_freqs.csv"
    TEMPS_OUT=$HOST_NAME"_"$JOB_NAME"_"$FREQ"_temps.csv"
  else
    FREQS_OUT=$HOST_NAME"_"$JOB_NAME"_freqs.csv"
    TEMPS_OUT=$HOST_NAME"_"$JOB_NAME"_temps.csv"
  fi
else
  echo "Hostname or benchmark name not found using default output files"
  FREQS_OUT="freqs.csv"
  TEMPS_OUT="temps.csv"
fi

#store starting and ending time as reported in slurm output
ORIG_START_TIME=`cat $1 | awk -F ' ' '{if ($1 == "Start") {for(i=3;i<=NF;i++) {printf $i" "} print ""}}'`
ORIG_END_TIME=`cat $1 | awk -F ' ' '{if ($1 == "End") {for(i=3;i<=NF;i++) {printf $i" "} print ""}}'`
#echo $ORIG_START_TIME
#echo $ORIG_END_TIME

#adjust start and end times to first match in frequency logs (logging delay may cause the reported times to be skipped in logs)
START_TIME=$ORIG_START_TIME
END_TIME=$ORIG_END_TIME
echo 'adjusting times to find in frequency logs...'
while ! grep "${START_TIME}" "${2}/cpu_usage/cpu_freq_info"; do
  START_TIME=`date "+%a %b %e %T %Y" -d "$START_TIME + 1 sec"`
done
while ! grep "${END_TIME}" "${2}/cpu_usage/cpu_freq_info"; do
  END_TIME=`date "+%a %b %e %T %Y" -d "$END_TIME - 1 sec"`
done
echo 'times adjusted successfully'

#grab data from start to end time for frequency
sed -n "/^${START_TIME}/,/^${END_TIME}/p" $2/cpu_usage/cpu_freq_info > temp
python3 ./freq_csv.py temp > temp2
tail -n +2 temp2 > $FREQS_OUT

#adjust start and end times to first match in temperature logs (logging delay may cause the reported times to be skipped in logs)
START_TIME=$ORIG_START_TIME
END_TIME=$ORIG_END_TIME
echo 'adjusting times to find in temperature logs...'
while ! grep "${START_TIME}" "${2}/cpu_temp/cpu_temp_record"; do
  START_TIME=`date "+%a %b %e %T %Y" -d "$START_TIME + 1 sec"`
done
while ! grep "${END_TIME}" "${2}/cpu_temp/cpu_temp_record"; do
  END_TIME=`date "+%a %b %e %T %Y" -d "$END_TIME - 1 sec"`
done
echo 'times adjusted successfully'

#grab data from start to end time for temperature
sed -n "/^${START_TIME}/,/^${END_TIME}/p" $2/cpu_temp/cpu_temp_record > temp
python3 ./temp_csv.py temp > temp2
tail -n +2 temp2 > $TEMPS_OUT

#remove temporary files
rm temp temp2
exit 0
