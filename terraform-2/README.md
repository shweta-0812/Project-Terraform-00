### This one is writing terraform from scratch without using Terraform Registry modules.

run `$terraform init`

run `$terraform plan -out=tfplan`

#### Optional - To provision actual resources on AWS infra using Terraform you will require to configure AWS SSO and AWS CLI and then run the following commands.

run `$terraform apply tfplan`

#### Verify resources on AWS console.


#### To remove all the provisioned resources:

run `$terraform destroy`
