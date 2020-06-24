#!/bin/bash

if [ "$1" == "" ]
then
	echo "You Idot"

else
		#Text Variables
		Red='\033[0;31m'
		Orange='\033[0;33m'
		NC='\033[0m'
		White='\033[1;37m'
		Yellow='\033[1;33m'
		Blue='\033[1;34m'
		Bold=$(tput bold)
		Normal=$(tput sgr0)

# Figlet of IPSweep
echo -e ${White}"$(figlet IPSweep)" | sed '$d'
echo -e ${Red}${Bold}'               Made By: TheMoodle'${White}'|_|   '
		
		#	Old Figlet Method
		#	echo -e ${White}' ___ ____  ____                         '
		#	echo -e '|_ _|  _ \/ ___|_      _____  ___ _ __  '
		#	echo -e ' | || |_) \___ \ \ /\ / / _ \/ _ \  _ \' 
		#	echo -e ' | ||  __/ ___) \ V  V /  __/  __/ |_) |'
		#	echo -e '|___|_|   |____/ \_/\_/ \___|\___| .__/ '
		#	echo -e ${Red}${Bold}'               Made By: TheMoodle'${White}'|_|   '

#Purge Problematic Files
	rm /tmp/ipsweep 2>/dev/null
	rm /tmp/ipsweep.txt 2>/dev/null

#Start Fping Scan
	fping -a -g $1 2>/dev/null > /tmp/ipsweep
	echo -e "${Yellow}Progress 1/2"

#Start Nmap Scan
	nmap -sP $1 2>/dev/null | grep "Nmap" | cut -d " " -f 5 | sed '1d;$d' >> /tmp/ipsweep
	echo -e "${Yellow}Progress 2/2"

#Sort and Concatenate Output File
	sort -V -i /tmp/ipsweep | uniq > /tmp/ipsweep.txt
	rm /tmp/ipsweep 2>/dev/null

#Echo Out the Results
	WC=`wc /tmp/ipsweep.txt | head -n1 | cut -d " " -f2`
	echo -e ${Bold}${Red}'Completed: '${Blue}$WC ${Red}'Hosts Found!'
	echo -e "${Normal}$(cat /tmp/ipsweep.txt)"

fi
