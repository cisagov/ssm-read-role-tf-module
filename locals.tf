locals {
  # Properly format username for use in an ARN
  iam_username = var.iam_username == "root" ? "root" : "user/${var.iam_username}"

  # If var.role_description contains "%s", use format() to replace the "%s"
  # with var.user, otherwise just use var.role_description as is
  role_description = length(regexall(".*%s.*", var.role_description)) > 0 ? format(var.role_description, var.user) : var.role_description

  # If var.role_name contains "%s", use format() to replace the "%s"
  # with var.user, otherwise just use var.role_name as is
  role_name = length(regexall(".*%s.*", var.role_name)) > 0 ? format(var.role_name, var.user) : var.role_name
}
