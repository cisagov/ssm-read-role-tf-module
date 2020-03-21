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

variable "ssm_regions" {
  type        = list(string)
  description = "AWS regions of target SSMs."
  default     = ["*"]
}
