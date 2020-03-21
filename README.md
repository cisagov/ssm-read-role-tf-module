# ssm-read-role-tf-module #

[![GitHub Build Status](https://github.com/cisagov/ssm-read-role-tf-module/workflows/build/badge.svg)](https://github.com/cisagov/ssm-read-role-tf-module/actions)

A Terraform module for creating an IAM role and policy for reading SSM parameters.

## Usage ##

```hcl
module "role_site.example.com" {
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = aws.provision-ssm-read-roles
  }

  account_ids = ["123456789012"]
  ssm_names = ["/server/foo/secret.txt", "/common/*"]
  user = "site.example.com"
}
```

You will also need a "meta-role" that you can assume for the purposes
of creating the IAM role for reading SSM parameter values.
This meta-role requires a permission policy similar to the following:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "1",
            "Effect": "Allow",
            "Action": [
                "iam:AttachRolePolicy"
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:DeleteRolePolicy",
                "iam:DetachRolePolicy",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListInstanceProfilesForRole",
                "iam:PutRolePolicy",
                "iam:TagRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:UpdateRole",
            ],
            "Resource": "arn:aws:iam::123456789012:role/ParameterStoreReadOnly-*"
        },
        {
            "Sid": "2",
            "Effect": "Allow",
            "Action": [
                "iam:CreatePolicy"
                "iam:CreatePolicyVersion",
                "iam:DeletePolicy",
                "iam:DeletePolicyVersion",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:ListPolicyVersions",
            ],
            "Resource": "arn:aws:iam::123456789012:policy/ParameterStoreReadOnly-*"
        }
    ]
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/ssm-read-role-tf-module/tree/develop/examples/basic_usage)

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| account_ids | AWS account IDs that are allowed to assume the role. | list(string) | [] | no |
| iam_username | The username of the IAM user allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s). | string | `root` | no |
| ssm_names | A list of SSM Parameter Store parameters that the created role will be allowed to access. | list(string) | | yes |
| ssm_regions | AWS regions of target SSMs (e.g. ["us-east-1", "us-east-2"]).  If not provided, defaults to all regions. | list(string) | `["*"]` | no |
| user | The name of the entity that the role is being created for (e.g. "test-user" or "host.example.com"). | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| policy | The IAM policy that can read the specified SSM Parameter Store parameters. |
| role | The IAM role that can read the specified SSM Parameter Store parameters. |

## Contributing ##

We welcome contributions!  Please see [here](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
