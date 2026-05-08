#!/bin/bash
#
# This script polls for running instance that is not currently added to Cloudwatch and
# add instances to Cloudwatch.
# Requirements:  AWS CLI and multiple AWS profile named mm-dev and mm-prod
#
#  Author:  	 Hilton Chan
#  Contributor:  Aaron C. (AWS CLI)
#
#  -- Sept. 27 2016

awsprofile=$1
runscript=`basename "$0"`

# Validate required parameters
if [ $# == 0 ]; then
	echo " Need at least one argument"
	echo "	eg: $runscript <aws profile name>"
	echo "	eg: $runscript XX-dev or XX-prod"
	exit
fi

if [ "$1" != "XX-dev" ] && [ "$1" != "XX-prod" ]; then
	echo 'Entry a valid profile'
	echo "	Example: $runscript XX-dev"
  echo "	Example2: $runscript XX-prod"
	exit
fi

InstanceIds1=$(aws ec2 describe-instances --profile $awsprofile --region us-west-1 --filters "Name=instance-state-name,Values=stopped" "Name=monitoring-state,Values=disabled" --query "Reservations[].Instances[].[InstanceId,Tags[?Key=='Name'].Value]" --output text --profile=mm-dev | sed 'N;s/\n/ /' | awk '{print $1}')
InstanceName1=$(aws ec2 describe-instances --profile $awsprofile --region us-west-1 --filters "Name=instance-state-name,Values=stopped" "Name=monitoring-state,Values=disabled" --query "Reservations[].Instances[].[InstanceId,Tags[?Key=='Name'].Value]" --output text --profile=mm-dev | sed 'N;s/\n/ /' | awk '{print $2}')

echo "Starting $1 instance polling to add to Cloudwatch"

echo "Instances found"
echo $InstanceIds1 | xargs -n1

for instance in $InstanceIds1;
	do aws cloudwatch put-metric-alarm \
		--region us-west-1 \
		--profile $awsprofile \
		--alarm-name awsec2-$instance-High-Status-Check-Failed-Any \
		--metric-name StatusCheckFailed \
		--namespace AWS/EC2 \
		--statistic Maximum \
		--dimensions Name=InstanceId,Value=$instance \
		--unit Count \
		--period 300 \
		--evaluation-periods 2 \
		--threshold 1 \
		--comparison-operator GreaterThanOrEqualToThreshold \
		--alarm-actions arn:aws:sns:us-xxxx-1:01234567891:xx_aws_ops;
	done

if [[ $? != 0 ]]; then
    echo "Something went wrong !"
    echo "Instances NOT added to Cloudwatch."
else
    echo "Instance/s added to Cloudwatch"
		echo $InstanceName1 | xargs -n1
fi