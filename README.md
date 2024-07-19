# Project-Terraform-00


### Environments Directory
The environment directory contains the Terraform configurations specific to each environment (e.g., test, stage, production). These configurations include the environment-specific settings, such as the region, instance sizes, and any other parameters that might vary between environments.

####Key Characteristics:

Environment-Specific Configuration: Each environment (test, stage, prod) has its own directory containing Terraform configurations tailored to that environment.

State Management: Each environment directory can have its own Terraform state file, allowing isolated management of resources.

Variables and Values: Environment-specific terraform.tfvars files contain variable values that differ between environments.

Deployment Commands: When you run Terraform commands (terraform init, terraform apply), you do so within the environment directories.


### Modules Directory
The modules directory contains reusable components (modules) that encapsulate common infrastructure patterns. These modules can be used across multiple environments, promoting reusability and reducing code duplication.

#### Key Characteristics:

Reusable Components: Modules are designed to be reusable across different environments and projects.

Encapsulation: Each module encapsulates specific resources and logic, such as VPC setup, compute resources, load balancers, etc.

Parameters: Modules are parameterized using variables, allowing flexibility and customization when used in different environments.


##Remember:

### .tfstate State file

- Do not commit state files to version control systems. Instead, use remote backends and keep configuration files (excluding state files) under version control.
- Regularly back up state files to prevent data loss. Many remote backends provide automatic backup and versioning features.

###.terraform.lock.hcl Lock file

You should include this file in your version control repository so that you can discuss potential changes to your external dependencies via code review, just as you would discuss potential changes to your configuration itself.


### Commands to test with apply to AWS
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
