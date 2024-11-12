# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "entity_name" {
  description = "The name of the entity that the role is being created for (e.g. \"test-user\" or \"host.example.com\")."
  nullable    = false
  type        = string
}

variable "ssm_names" {
  description = "A list of SSM Parameter Store parameters that the created role will be allowed to access."
  nullable    = false
  type        = list(string)
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "account_ids" {
  default     = []
  description = "AWS account IDs that are allowed to assume the role."
  nullable    = false
  type        = list(string)
}

variable "iam_usernames" {
  default     = ["root"]
  description = "The list of IAM usernames allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s).  Note that including \"root\" in this list will override any other usernames in the list."
  nullable    = false
  type        = list(string)
}

variable "role_description" {
  default     = "Allows read-only access to SSM Parameter Store parameters required for %s."
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that the \"%s\" in this value will get replaced with the entity_name variable.  If there are no instances of \"%s\" present in this value, no replacement will be made and the value will be used as is.  Including more than one instance of \"%s\" in this value will result in a Terraform error, so don't do that."
  nullable    = false
  type        = string
}

variable "role_name" {
  default     = "ParameterStoreReadOnly-%s"
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that the \"%s\" in this value will get replaced with the entity_name variable.  If there are no instances of \"%s\" present in this value, no replacement will be made and the value will be used as is.  Including more than one instance of \"%s\" in this value will result in a Terraform error, so don't do that.  If the role name is longer than the current AWS limit of 64 characters (either as-is or after entity_name replacement), the role name will be truncated to the first 64 characters."
  nullable    = false
  type        = string
}

variable "ssm_regions" {
  default     = ["*"]
  description = "AWS regions of target SSMs (e.g. [\"us-east-1\", \"us-east-2\"]).  If not provided, defaults to all regions."
  nullable    = false
  type        = list(string)
}
