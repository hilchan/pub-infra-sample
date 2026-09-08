# Remote config

```
terraform remote config \
    -backend=s3 \
    -backend-config="bucket=XXXXX" \
    -backend-config="key=/APP/waf-qa/QAE/terraform.tfstate" \
    -backend-config="region=us-XXXX-1" \
    -backend-config="profile=h-qa"
```

```
terraform plan \
  -var-file="../../tf-base/settings/secrets-qa.tfvars" \
  -var-file="settings/app.tfvars"
```

## CHANGE HISTORY

2017-03-10 - Initially deployed Hilton Chan
