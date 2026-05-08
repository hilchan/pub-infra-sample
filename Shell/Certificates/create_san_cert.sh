#!/bin/bash
#
# Generate SAN csr based on fqdn for Leapfrog
#
# Hackily created by Hilton Chan to quickly turn in request for new cert on 2/16.2018

if [ -z $1 ]; then
  echo "Please specify the FQDN to generate CSR in SAN cert";
  echo "eg: int.domain.net";
  exit
  else
    echo "Adding SSL SAN config for '$1' ";
fi

fqdn=$1
# fqdn2="*.domain2.net"

# Create config file
echo '[ req ]' > config/$fqdn.config
echo 'prompt = no' >> config/$fqdn.config
echo 'default_bits = 4096' >> config/$fqdn.config
echo 'distinguished_name = req_distinguished_name' >> config/$fqdn.config
echo 'req_extensions = req_ext' >> config/$fqdn.config
echo " " >> config/$fqdn.config

echo '[ req_distinguished_name ]' >> config/$fqdn.config
echo 'countryName=US' >> config/$fqdn.config
echo 'stateOrProvinceName=California' >> config/$fqdn.config
echo 'localityName=San Francisco' >> config/$fqdn.config
echo '0.organizationName=Company, Inc.' >> config/$fqdn.config
echo 'organizationalUnitName=DevOps' >> config/$fqdn.config
echo 'commonName='$fqdn >> config/$fqdn.config
echo 'emailAddress=mmdevops@mail.com' >> config/$fqdn.config
echo " " >> config/$fqdn.config

echo '[ req_ext ]' >> config/$fqdn.config
echo 'subjectAltName' = @alt_names >> config/$fqdn.config
echo " " >> config/$fqdn.config

echo '[alt_names]' >> config/$fqdn.config
echo 'DNS.1 = '$fqdn >> config/$fqdn.config
# echo 'DNS.2 = *.'$fqdn >> config/$fqdn.config

# Generate CSR and Private key
openssl req -out wildcard.$fqdn.csr -newkey rsa:2048 -nodes -keyout wildcard.$fqdn.key -config config/$fqdn.config

# API to upload CSR to Digicert
curl -X POST -H "Content-Type: application/json" -H "X-DC-DEVKEY: 0123456789abcdef0123456789abcdef" -d '{"certificate": {"common_name": "'$fqdn'", "csr": "'$(cat wildcard.$fqdn.csr | sed ':a;N;$!ba;s/\n/\\n/g')'"}}' https://www.digicert.com/services/v2/order/certificate/ssl_plus 
