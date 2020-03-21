# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "ssm_names" {
  type        = list(string)
  description = "A list of SSM Parameter Store parameters that the created role will be allowed to access."
}

variable "user" {
  type        = string
  description = "The name of the entity that the role is being created for (e.g. \"test-user\" or \"host.example.com\")."
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

variable "iam_username" {
  type        = string
  description = "The username of the IAM user allowed to assume the role.  If not provided, defaults to allowing any user in the specified account(s)."
  default     = "root"
}

variable "role_description" {
  description = "The description to associate with the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that a \"%s\" in this value will get replaced with the user variable."
  default     = "Allows read-only access to SSM Parameter Store parameters required for %s."
}

variable "role_name" {
  description = "The name to assign the IAM role (as well as the corresponding policy) that allows read-only access to the specified SSM Parameter Store parameters.  Note that a \"%s\" in this value will get replaced with the user variable."
  default     = "ParameterStoreReadOnly-%s"
}

variable "ssm_regions" {
  type        = list(string)
  description = "AWS regions of target SSMs (e.g. [\"us-east-1\", \"us-east-2\"]).  If not provided, defaults to all regions."
  default     = ["*"]
}
