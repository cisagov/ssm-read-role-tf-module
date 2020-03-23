# Create an AWS IAM role for reading SSM parameters #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| policy | The IAM policy that can read the specified SSM Parameter Store parameters for site.example.com. |
| role | The IAM role that can read the specified SSM Parameter Store parameters for site.example.com. |
