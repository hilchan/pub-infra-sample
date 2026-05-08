#!/usr/bin/env python

from boto import ec2
import sys

string_match = ""
if len(sys.argv) > 1:
	string_match = str(sys.argv[1]).lower()

#from termcolor import colored
class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

def disable(self):
        self.HEADER = ''
        self.OKBLUE = ''
        self.OKGREEN = ''
        self.WARNING = ''
        self.FAIL = ''
        self.ENDC = ''

accts = ["aws-acct1", "aws-acct2"]
regions = ["us-xxxx-1", "us-xxxx-2"]
for acct in accts:
	for region in regions:
		connection = ec2.connect_to_region(region, profile_name= acct)
		instances = connection.get_only_instances()
		found_match = False
		for instance in instances:
			if (string_match in str(instance.tags['Name']).lower() or string_match in str(instance.id).lower()):
				if instance.state == "stopped":
					print bcolors.FAIL + region + "\t" + acct + "\t" + instance.private_ip_address + "\t" + instance.id + "\t" + str(instance.tags['Name']) + "\t" + " STOPPED\t" + instance.key_name + "\t" + instance.image_id + bcolors.ENDC
				else:
					print  region + "\t" + acct + "\t" + instance.private_ip_address + "\t" + instance.id + "\t" +  str(instance.tags['Name']) + "\t" + " RUNNING\t" + bcolors.OKBLUE + instance.key_name + "\t" + instance.image_id + bcolors.ENDC
				found_match = True
		if found_match:
			print ""
