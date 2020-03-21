# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "hostname" {
  type        = string
  description = "The FQDN corresponding to the host that will be reading the SSM params (e.g. site.example.com)"
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
  description = "AWS account IDs that are to be allowed to assume the role"
  default     = []
}

variable "ssm_regions" {
  type        = list(string)
  description = "AWS regions of target SSMs"
  default     = ["*"]
}
