# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "entity_name" {
  type        = string
  description = "The name of the entity that the role is being created for (e.g. \"test-user\" or \"host.example.com\")."
}

variable "ssm_names" {
  type        = list(string)
  description = "A list of SSM Parameter Store parameters that the created role will be allowed to access."
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  type        = list(string)
  description = "AWS account IDs that are allowed to assume the role."
  default     = []
}

variable "iam_usernames" {
  type        = list(string)
  description = "The list of IAM usernames allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s).  Note that including \"root\" in this list will override any other usernames in the list."
  default     = ["root"]
}

variable "role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that the \"%s\" in this value will get replaced with the entity_name variable.  If there are no instances of \"%s\" present in this value, no replacement will be made and the value will be used as is.  Including more than one instance of \"%s\" in this value will result in a Terraform error, so don't do that."
  default     = "Allows read-only access to SSM Parameter Store parameters required for %s."
}

variable "role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that the \"%s\" in this value will get replaced with the entity_name variable.  If there are no instances of \"%s\" present in this value, no replacement will be made and the value will be used as is.  Including more than one instance of \"%s\" in this value will result in a Terraform error, so don't do that.  If the role name is longer than the current AWS limit of 64 characters (either as-is or after entity_name replacement), the role name will be truncated to the first 64 characters."
  default     = "ParameterStoreReadOnly-%s"
}

variable "ssm_regions" {
  type        = list(string)
  description = "AWS regions of target SSMs (e.g. [\"us-east-1\", \"us-east-2\"]).  If not provided, defaults to all regions."
  default     = ["*"]
}
