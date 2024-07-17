# Project-Terraform-00

How to modularise Terraform code so that it is
- legible
- scalable
- maintainable

It covers:

code style and formatting

resource organization

lifecycle management through meta-arguments, versioning, and sensitive data management.

Refer - https://developer.hashicorp.com/terraform/language/style

Things to remember:
1. Run `terraform fmt` and `terraform validate` before committing your code.
2. Always include a default provider configuration.

### Environments Directory
The environment directory contains the Terraform configurations specific to each environment (e.g., test, stage, production). These configurations include the environment-specific settings, such as the region, instance sizes, and any other parameters that might vary between environments.

Key Characteristics:

Environment-Specific Configuration: Each environment (test, stage, prod) has its own directory containing Terraform configurations tailored to that environment.

State Management: Each environment directory can have its own Terraform state file, allowing isolated management of resources.

Variables and Values: Environment-specific terraform.tfvars files contain variable values that differ between environments.

Deployment Commands: When you run Terraform commands (terraform init, terraform apply), you do so within the environment directories.


### Modules Directory
The modules directory contains reusable components (modules) that encapsulate common infrastructure patterns. These modules can be used across multiple environments, promoting reusability and reducing code duplication.

Key Characteristics:

Reusable Components: Modules are designed to be reusable across different environments and projects.

Encapsulation: Each module encapsulates specific resources and logic, such as VPC setup, compute resources, load balancers, etc.

Parameters: Modules are parameterized using variables, allowing flexibility and customization when used in different environments.

Source: Environment configurations reference modules using the source attribute, pointing to the module's directory.


##Remember:

### Managing State Files

- Remote State Storage:

Use remote backends for storing state files to enable collaboration and ensure state consistency.

- State Locking:

Enable state locking to prevent concurrent modifications. Remote backends like S3 (with DynamoDB for locking) or Terraform Cloud support state locking.

- Security:

Encrypt state files at rest and in transit, especially when using remote backends.
Restrict access to the state file to authorized users only, as it may contain sensitive information.

- Version Control:

Do not commit state files to version control systems. Instead, use remote backends and keep configuration files (excluding state files) under version control.

- State File Backups:

Regularly back up state files to prevent data loss. Many remote backends provide automatic backup and versioning features.

- .terraform.lock.hcl Lock file

The lock file is always named .terraform.lock.hcl. You should include this file in your version control repository so that you can discuss potential changes to your external dependencies via code review, just as you would discuss potential changes to your configuration itself.

- Test files

By default, tests within Terraform create real infrastructure and can run assertions and validations against that infrastructure because you are testing Terraform's core functionality by executing operations and validating the infrastructure Terraform creates.
