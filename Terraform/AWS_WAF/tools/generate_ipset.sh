#!/bin/bash
#
# This script used to generate ipset code based on new IP listings.
#
#  Author:  	 Hilton Chan

whitelist="superwhitelists.txt"
tffile="waf-mesos-superwhitelist.tf"
ipsetname="superwhitelist2"

# Generate new file.
echo -e resource "\"aws_waf_ipset"\" "\"$ipsetname"\" "{" > $tffile
echo -e " " name = \"$ipsetname\" >> $tffile
echo -e " " >> $tffile

for list in `cat $whitelist`; 
   do 
	echo -e " " ip_set_descriptors "{" >> $tffile;  echo -e "\t" type = "\"IPV4"\" >> $tffile; echo -e "\t" value = \"$list\" >> $tffile; echo -e "\t" "}" >> $tffile;
   done;

# Closing new file
echo -e "}" >> $tffile
