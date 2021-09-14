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
  entity_name = "site.example.com"
  ssm_names   = ["/server/foo/secret.txt", "/common/*"]
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

- [Basic usage](https://github.com/cisagov/ssm-read-role-tf-module/tree/develop/examples/basic_usage)

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.14.0 |
| aws | ~> 3.38 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.38 |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_policy.ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ssm_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ssm_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ssm_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_ids | AWS account IDs that are allowed to assume the role. | `list(string)` | `[]` | no |
| entity\_name | The name of the entity that the role is being created for (e.g. "test-user" or "host.example.com"). | `string` | n/a | yes |
| iam\_usernames | The list of IAM usernames allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s).  Note that including "root" in this list will override any other usernames in the list. | `list(string)` | `["root"]` | no |
| role\_description | The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that a "%s" in this value will get replaced with the entity\_name variable. | `string` | `"Allows read-only access to SSM Parameter Store parameters required for %s."` | no |
| role\_name | The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that a "%s" in this value will get replaced with the entity\_name variable. | `string` | `"ParameterStoreReadOnly-%s"` | no |
| ssm\_names | A list of SSM Parameter Store parameters that the created role will be allowed to access. | `list(string)` | n/a | yes |
| ssm\_regions | AWS regions of target SSMs (e.g. ["us-east-1", "us-east-2"]).  If not provided, defaults to all regions. | `list(string)` | `["*"]` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| policy | The IAM policy that can read the specified SSM Parameter Store parameters. |
| role | The IAM role that can read the specified SSM Parameter Store parameters. |

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, these are the main directory and
every directory under `examples/`.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
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
