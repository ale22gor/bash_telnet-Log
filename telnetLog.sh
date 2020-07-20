#!/bin/bash

#check number of args
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Illegal number of parameters"
    exit 2
fi

#set current date and date with time
currDateAndTime=`date +"%Y-%m-%d_%T"`
currDate=`date +"%Y-%m-%d"`

#create dir for logs
mkdir -p  "${currDate}"

ip=$1
comment=$2
if [ "$#" -eq 2 ]; then #check existence of second arg and comment
	
	if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then #check if first arg is ip
		#set ip and comment variable		
		ip=$1
		comment=$2
	elif [[ $2 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then #check if second arg is ip
		#set ip and comment variable		
		ip=$2
		comment=$1
	else
		#if ip isnt set exit
		echo "ip is not set"
		exit 2
	fi
	#create log file name variable
	logFileName="${currDate}//${comment}_${ip}_$currDateAndTime".log
	#connect to host and start log
	script -c "telnet ${ip}" ${logFileName}

elif [ "$#" -eq 1 ]; then #if comment isnt set then check existence of first arg
	if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then #check if first arg is ip
		#set ip		
		ip=$1
	else   
		#if ip isnt set exit
		echo "ip is not set"   
		exit 2
	fi
	#create log file name variable
	logFileName="${currDate}//${ip}_${currDateAndTime}".log
	#connect to host and start log
	script -c "telnet ${ip}" ${logFileName}
else
   #i dont know why im writing this
   echo "something strange happen"
   exit 2
fi









