## Sample VPC Prod Provision Project

## CONSUMPTION
Terraform version v0.11.7 or greater is required
Do not use v0.11.8, bugs with remote S3 and fails to initialized

## BRANCH MODEL

## CONTRIBUTION

## USAGE

1. configure your secrets file

#### Where secrets-dev.tfvars is something like:

```
# provider core reqs
account_id = "12345678910" #aws account number
aws_profile = "my-prod" #aws profile from vault
shared_credentials_file = "~/.aws/credentials"
keypair = "Sysops" #keypair to use in aws account

```

2. Configure terraform for remote:

#### S3 will automatically create path in bucket for this file, no manual intervention required.
#### Make required substitutions below
```
terraform init \
    -backend-config="bucket=mm-ops-prdshrd2" \
    -backend-config="key=vpc/prd/vpc-prd.tfstate" \
    -backend-config="region=us-west-2"\
    -backend-config="profile=mm-prod"


terraform remote config \
-backend=s3 \
-backend-config="bucket=my-prdshrd2" \
-backend-config="key=vpc/prd/vpc-prd.tfstate" \
-backend-config="region=us-xxxx-2" \
-backend-config="profile=my-prod"
```

```
$ Enter directory of this project
$ terraform init -var-file="../settings/prd-vpc.tfvars"
```

3. execute terraform

```
terraform plan -var-file="../settings/prd-vpc.tfvars"
```


## CHANGE HISTORY

2018.09.07 - Hilton Chan
2020-05-06 - Hilton Chan
  To include Opsec VPN and routing
