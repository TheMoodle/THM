#!/bin/bash

if [ "$1" == "" ]
then
	echo "You Idot"
#	echo -e "$(motivate)" # Uncommment for motivation! https://github.com/mubaris/motivate

else
	
		#Variables
		spinner=( '|' '/' '-' '\');
		Red='\033[0;31m'
		Orange='\033[0;33m'
		NC='\033[0m'
		White='\033[1;37m'
		Yellow='\033[1;33m'
		Blue='\033[1;34m'
		Bold=$(tput bold)
		Normal=$(tput sgr0)

#Loading Animation
		spin(){
		  while [ 1 ]
		  do
		    for i in ${spinner[@]};
		    do
		      echo -ne "${Yellow}\rInitializing $i";
		      sleep 0.3;
		    done;
		  done
		}

# Figlet of IPSweep
echo -e ${White}"$(figlet IPSweep)" | sed '$d'
echo -e ${Red}${Bold}'               Made By: TheMoodle'${White}'|_|   '

#Purge Problematic Files
	rm /tmp/ipsweep 2>/dev/null
	rm /tmp/ipsweep.txt 2>/dev/null

#Start Scanning
	spin &
  	pid=$!
	fping -a -g $1 2>/dev/null > /tmp/ipsweep &
	P1=$!
	nmap -sP $1 2>/dev/null | grep "Nmap" | cut -d " " -f 5 | sed '1d;$d' >> /tmp/ipsweep &
	P2=$!
	arp | sed '/incomplete/d' | cut -d " " -f 1 | sed '1d' >> /tmp/ipsweep &
	P3=$!
	wait $P1 $P2 $P3

#Sort and Concatenate Output File
	sort -V -i /tmp/ipsweep | uniq > /tmp/ipsweep.txt
	rm /tmp/ipsweep 2>/dev/null

#Echo Out the Results
	kill $pid 
	WC=`wc /tmp/ipsweep.txt | head -n1 | cut -d " " -f2`
	echo -e ${Bold}${Red}'\rCompleted: '${Blue}$WC${Red} 'Hosts Found!'
	echo -e "${NC}$(cat /tmp/ipsweep.txt)"
fi

if [ "$2" == "" ]
	then
		exit
	else
		cp /tmp/ipsweep.txt $2
		exit
fi
