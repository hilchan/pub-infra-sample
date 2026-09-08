# This script checks public certificate matches the private key by comparing the checksum and upload to AWS..
# 
# Author: Hilton Chan
# Written: 1/03/2017
#
fqdn=path/to/secure-certificates-server
runscript=`basename "$0"`
red='\e[0;31m'
green='\e[0;32m'
blue='\e[0;34m'
NC='\e[0m' # No Color
 
if [ -z "$1" ]; then
    echo -e "${blue}Usage:${NC} $runscript ${red}<full domain name of certificate only> <aws profile>${NC}"
    echo -e "${blue}Example${NC}: $runscript host.domain1.net xx-dev or xx-prod"
    echo "Make sure your cert is in $fqdn"
    exit
fi
 
if [ -f "$fqdn/$1.crt" ]
then
if [ "`openssl x509 -in $fqdn/$1.crt -noout -modulus`" = \
     "`openssl rsa -in $fqdn/$1.key -noout -modulus`" ]; \
     then echo -e "${green}Certificate Matches${NC}"; else echo -e "${red}Certificate pair DOES NOT MATCH, please get the matching file${NC}";
    fi
else echo -e "${blue}Certificate file does not exist.${NC}"
exit
fi

certname=$1

if [ "$2" != "xx-dev" ] && [ "$2" != "xx-prod" ]; then
	echo 'Enter a valid aws profile'
	echo "	Example: $runscript <fqdn> xx-dev"
  echo "	Example2: $runscript <fqdn> xx-prod"
	exit
fi

# AWS upload
aws iam upload-server-certificate --server-certificate-name $certname --certificate-body file://$certname.crt --private-key file://$certname.key --certificate-chain file://$certname.ca --profile $2