# Requirement
Terraform 0.9.6
 - Must "TF_VAR_vsphere_password=<vCenter passwod>" to your env variable

# Remote config (Placeholder - Do not use remote config)
```terraform remote config \
    -backend=s3 \
    -backend-config="bucket=mm-ops-devshrd" \
    -backend-config="key=/SJC-VM/mesos/qa/terraform.tfstate" \
    -backend-config="region=us-west-1" \
    -backend-config="profile=mm-dev"
```

# Stage
```terraform remote config \
    -backend=s3 \
    -backend-config="bucket=mm-ops-devshrd" \
    -backend-config="key=/SJC-VM/mesos/stg/terraform.tfstate" \
    -backend-config="region=us-west-1" \
    -backend-config="profile=mm-prd"
```

# Execute
```
From environment directory.
  terraform plan
  terraform apply
```

# Package
This includes Mesos Private, Public, Master and soon ELK stack.
After Provisioning, make sure to add VM guest to mm-corp.net DNS.

## CHANGE HISTORY
