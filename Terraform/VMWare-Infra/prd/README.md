# Requirement
Terraform 0.9.6

# Remote config
```terraform remote config \
    -backend=s3 \
    -backend-config="S3-XXX" \
    -backend-config="key=var-xxx" \
    -backend-config="region=XXX" \
    -backend-config="profile=xxx"
```

# Execute
```
From environment directory.
  terraform plan
  terraform apply
```

## CHANGE HISTORY
