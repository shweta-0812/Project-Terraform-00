
1. Define Provider and related details in tfvars file
2. Create ECR repo
3. Create permissions to Read, Write and Manage ECR for iam role
4. Create iam role
5. Attach iam policy to role

### Commands to test without apply
`terraform init`

`terraform plan --var-file=main.tfvars -out=tfplan`

`terraform fmt`

`terraform validate` 

### Commands to run and apply to AWS
`terraform init`

`terraform plan --var-file=main.tfvars -out=tfplan`

`terraform apply`

`terraform fmt`

`terraform validate` 
