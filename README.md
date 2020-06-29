# THM

This repository contains useful scripts/tools that I use on the [Tryhackme](https://tryhackme.com/) rooms.

## Setup.py
[A python setup script](setup.py) to automatically setup a directory with a README for notes for any room. Call it with the name in the url and it'll setup a directory for you.  

`Usage: setup.py [URL Extension] {Optional: Name of Directory}`

## IPSweep.sh
[A bash script](ipsweep.sh) that automatically combines the results of an Nmap, Fping and Arp scan for host discovery.

`Usage: ./ipsweep.sh [IP Address or range] {Optional: Output file}`

`Example: ./ipsweep.sh 192.168.1.0/24 /root/ip.txt`
