#!/bin/bash

#Modify UNIT to change from seconds(s), minutes(m), or hours(h)
UNIT=s

#Set the frequency of recordings (default is minutes)
#Example to record system settings every 5 minutes: FREQ=5
FREQ=1

#Must record memory usage
#Must record cpu usage
#CPU Temperature recording
base_dir=$1
temp_file="./cpu_temp/cpu_temp_record"
mem_file="./cpu_mem/cpu_memory_record"
mount_file="./cpu_mem/cpu_mount_record"
usage_file="./cpu_usage/cpu_freq_info"


get_cpu_temp(){
	echo "------------------------------------------------------------" >> $temp_file
	python3 -c "import time; print(time.asctime(time.localtime(time.time())))" >> $temp_file
	sensors >> $temp_file

}

get_cpu_memory(){
	python3 -c "import time; print(time.asctime(time.localtime(time.time())))" >> $mem_file
	vmstat >> $mem_file
	date>>$mount_file
	df >> $mount_file
	df -h >>$mount_file	
	echo " " >>$mem_file
	echo " ">>$mount_file

}


get_cpu_usage(){
  python3 -c "import time; print(time.asctime(time.localtime(time.time())))" >> $usage_file
  #cpufreq-info >> $usage_file
  if [ -f "/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq" ]; then                             
    for cpu in /sys/devices/system/cpu/*; do                                                          
      if [ -d $cpu ] && [[ ${cpu} =~ [[:digit:]]+$ ]]; then                                           
        device=${cpu##*/}                                                                             
        ext="/cpufreq/scaling_cur_freq"                                                               
        if [ -f $cpu$ext ]; then                                                                      
          out=`cat $cpu$ext`
          echo $device" frequency (KHz): "$out >> $usage_file                
        fi
      fi                                                                                              
    done                                                                                              
  elif [ -f "/proc/cpuinfo" ]; then                                                                   
    cat /proc/cpuinfo | awk -F ' ' '{ if ($1 == "processor") {printf "cpu"$3" frequency (MHz): "} else if ($1 == "cpu" && $2 == "MHz") {print $4} }' >> $usage_file
  fi
}

gather_data(){
	get_cpu_temp
	get_cpu_memory
	get_cpu_usage
#	for i in {$NUMRUNS}
  while true
	do
		sleep $FREQ$UNIT
		get_cpu_temp
		get_cpu_memory
		get_cpu_usage
	done

}


setup_directories(){
  mkdir -p $base_dir
  cd $base_dir
	mkdir -p cpu_temp
	mkdir -p cpu_mem
	mkdir -p cpu_usage
}

umask 000
setup_directories
gather_data
