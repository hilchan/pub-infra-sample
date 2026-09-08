## WAF Rule Terraform IPset generator.

## CONSUMPTION
Use for updating IP list from wiki found in
https://wiki.mm-corp.net/confluence/display/SysOps/Recreate+a+IPSet+Condition+for+use+in+WAF+Rules

## This tool is use for generating new terraform 0.8.8 code with the set of IP required above.
* Simply replace the terraform ...ipset.tf file

#### Branch model
* master  = use by QA, Staging, Demo and Production environment.

#### Instead of Branch model to launch different environment, ALB is using directory model to identify each environment.

Each environment will have it's individual instructions.

## CHANGE HISTORY
* Created by Hilton Chan 3/22/2017.

# Remote config for shared IP
- Refer to each environment for details.
