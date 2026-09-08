#!/bin/bash
#Create a single primary partiton with whole disk size and create LVM PV on it
disk=$1
partno=1
vol=dockervol
if [[ -z $disk ]]; then
 echo "Usage: $0 disk device name: e.g $0 /dev/sdb"
 exit
fi

if [[ -e ${disk}${partno} ]]; then
 echo "==> ${disk}${partno} already exist"
 exit
fi

echo "==> Create MBR label"
sudo parted -s $disk  mklabel msdos
ncyl=$(sudo parted $disk unit cyl print  | sed -n 's/.*: \([0-9]*\)cyl/\1/p')

if [[ $ncyl != [0-9]* ]]; then
 echo "disk $disk has invalid cylinders number: $ncyl"
 exit
fi

echo "==> create primary parition  $partno with $ncyl cylinders"
sudo parted -a optimal $disk mkpart primary 0cyl ${ncyl}cyl
echo "==> set partition $partno to type: lvm "
sudo parted $disk set $partno lvm on
sudo partprobe > /dev/null 2>&1
echo "==> create PV ${disk}${partno} "

## Create volume
sudo vgcreate vg_$vol ${disk}${partno}
S=$(sudo vgdisplay vg_$vol | grep Total | perl -pe 's/[^0-9]+//g')
sudo lvcreate -l $S vg_$vol -n lv_$vol
#mke2fs -t ext4 /dev/vg_"$vol"/lv_$vol
sudo mke2fs -t ext4 /dev/vg_"$vol"/lv_$vol
sudo tune2fs -m 0 /dev/vg_"$vol"/lv_$vol
sudo mkdir /opt/mesos
sudo mount /dev/vg_"$vol"/lv_$vol /opt/mesos
sudo sh -c 'echo -e "/dev/vg_'$vol'/lv_'$vol'\t\t/opt/mesos\t\text4\tnoatime\t\t0 2" >> /etc/fstab'

## Expand OS var and home volume
sudo lvextend -L+1G  /dev/VolGroup00/LogVol03
sudo lvextend -l 100%FREE /dev/VolGroup00/LogVol02
sudo xfs_growfs   /dev/VolGroup00/LogVol03
sudo xfs_growfs   /dev/VolGroup00/LogVol02

## Replace hostname with FQDN
fqdn=$(sed -n '4p' /etc/hosts | awk '{print $2}')
hstnm=`hostname`
sudo sed -i "s/$hst/$fqdn/" /etc/sysconfig/network
sudo hostname $fqdn

## Replace incorrect loopback address in /etc/hosts
if grep "127.0.1.1" hosts;
  then
    echo "Loopback previously corrected.  No Change";
    exit
  else
    echo "Found incorrect Loopback, correcting...";
    sudo sed -i "s/127.0.1.1/127.0.0.1/" /etc/hosts;
    echo "Loopback corrected..."
fi
