#!/bin/bash
#
# Generate config file based on fqdn

if [ -z $1 ]; then
  echo "Please specify the FQDN to generate CSR in SAN cert";
  echo "eg: host.domain.net";
  exit
  else
    echo "Adding SSL SAN config for '$1' ";
fi

cp template.config $1.config
fqdn=$1
echo $fqdn

# Create config file
echo '[ req ]' > $fqdn.config
echo 'prompt = no' >> $fqdn.config
echo 'default_bits = 4096' >> $fqdn.config
echo 'distinguished_name = req_distinguished_name' >> $fqdn.config
echo 'req_extensions = req_ext' >> $fqdn.config
echo " " >> $fqdn.config

echo '[ req_distinguished_name ]' >> $fqdn.config
echo 'countryName=US' >> $fqdn.config
echo 'stateOrProvinceName=California' >> $fqdn.config
echo 'localityName=San Francisco' >> $fqdn.config
echo '0.organizationName=MarkMonitor, Inc.' >> $fqdn.config
echo 'organizationalUnitName=DevOps' >> $fqdn.config
echo 'commonName='$fqdn >> $fqdn.config
echo 'emailAddress=mmdevops@markmonitor.com' >> $fqdn.config
echo " " >> $fqdn.config

echo '[ req_ext ]' >> $fqdn.config
echo 'subjectAltName' = @alt_names >> $fqdn.config
echo " " >> $fqdn.config

echo '[alt_names]' >> $fqdn.config
echo 'DNS.1 = '$fqdn >> $fqdn.config
echo 'DNS.2 = *.'$fqdn >> $fqdn.config
