# Create an AWS IAM role for reading certificate information #

## Usage ##

To run this example you need to execute the `terraform init` command
followed by the `terraform apply` command.

Note that this example may create resources which cost money. Run
`terraform destroy` when you no longer need these resources.

## Outputs ##

| Name | Description |
|------|-------------|
| role_arn | The ARN corresponding to the IAM role to be used for reading certificate data for the specified hostname |
