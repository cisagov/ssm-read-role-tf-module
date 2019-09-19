# ssm-read-role-tf-module #

[![Build Status](https://travis-ci.com/cisagov/ssm-read-role-tf-module.svg?branch=develop)](https://travis-ci.com/cisagov/ssm-read-role-tf-module)

A Terraform module for creating an IAM role for reading SSM parameters.

## Usage ##

```hcl
module "role_site.example.com" {
  source = "github.com/cisagov/ssm-read-role-tf-module"

  providers = {
    aws = "aws"
  }

  account_ids = [
    "123456789012"
  ]
  ssm_names = ["/server/foo/secret.txt", "/server/foo/other_secret.txt"]
  hostname = "site.example.com"
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
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:GetRole",
                "iam:ListInstanceProfilesForRole",
                "iam:DeleteRolePolicy",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:UpdateRole",
                "iam:PutRolePolicy",
                "iam:GetRolePolicy"
            ],
            "Resource": "arn:aws:iam::123456789012:role/ReadSSM-*"
        }
    ]
}
```

## Examples ##

* [Basic usage](https://github.com/cisagov/ssm-read-role-tf-module/tree/develop/examples/basic_usage)

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| account_ids | AWS account IDs that are to be allowed to assume the role | list(string) | [] | no |
| ssm_names | A list of SSM keys that the created role will be allowed to access. | list(string) | | yes |
| ssm_regions | AWS regions of target SSMs | list(string) | `["*"]` | no |
| hostname | The FQDN corresponding to the SSM parameters to be read (e.g. site.example.com) | string | | yes |

## Outputs ##

| Name | Description |
|------|-------------|
| arn | The ARN of the newly created role |

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
