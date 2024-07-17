#### Pre-requisites:
1. Docker Daemon - Make sure the docker daemon is running on your local machine.
2. Terraform - Make sure it is installed on your local machine.

#### Then run the following commands to test the terraform example

run `$terraform init`

run `$terraform plan -out=tfplan`

run `$terraform apply tfplan`

run `$terraform destroy`

### Verify:

Login to Docker Desktop and view the container.

###To remove all the provisioned resources:

run `$terraform destroy`
