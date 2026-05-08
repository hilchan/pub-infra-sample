#!/bin/bash

# EMAIL
# comma separated list of recipients
RECIPIENTS="distro@email.com"
SUBJECT="Manual Provisioning Script to expand volume"
LOGFILE="/tmp/provision.log"

# Tell bash that it should exit the script if any statement
# returns a non-true return value.
set -e

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>$LOGFILE 2>&1

function startup () {
  echo "-----------------------------------"
  echo " START OF SCRIPT "
  echo "-----------------------------------"
  echo "Starting provisioning script...additional output is being" >&3
  echo "logged to $LOGFILE and will be sent to $RECIPIENTS" >&3
}

echo "-------------     Start Expanding /opt/mesos Volume      --------------"
#Create a single primary partiton with whole disk size and create LVM PV on it
volgrp=vg_dockervol
vardir=lv_dockervol

echo "==> Expanding /opt/mesos +100gb"
if [[ $(vgdisplay vg_dockervol | grep Free | awk '{ print $5 }') < 1025 ]]; \
  then
    echo "No space available in Volume $volgrp";
    echo "Aborting..."
    exit
  else
    echo "Volume $volgrp available space found";
    echo "Drive expansion in progress..."
    sudo lvextend -L+1G  /dev/VolGroup00/LogVol03
    sudo lvextend -l 100%FREE /dev/VolGroup00/LogVol02
    sudo xfs_growfs   /dev/VolGroup00/LogVol03
    sudo xfs_growfs   /dev/VolGroup00/LogVol02
fi
echo "-------------       END Expanding OS Volume        --------------"

function finish {
  /usr/bin/cat $LOGFILE | /bin/mail -s "$SUBJECT" "$RECIPIENTS"
  /usr/bin/rm $LOGFILE
}

trap finish EXIT

startup

echo "OS Volume expanded."

echo "-----------------------------------"
echo " END OF SCRIPT"
echo "-----------------------------------"

# Clean up IO redirection
exec 1>&3 3>&-      # Restore stdout and close file descriptor #3.
exec 1>&4 4>&-      # Restore stderr and close file descriptor #4.

exit 0
