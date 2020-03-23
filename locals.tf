locals {
  # Properly format usernames for use in an ARN
  iam_usernames = contains(var.iam_usernames, "root") ? ["root"] : formatlist("user/%s", var.iam_usernames)

  # If var.role_description contains "%s", use format() to replace the "%s"
  # with var.entity_name, otherwise just use var.role_description as is
  role_description = length(regexall(".*%s.*", var.role_description)) > 0 ? format(var.role_description, var.entity_name) : var.role_description

  # If var.role_name contains "%s", use format() to replace the "%s"
  # with var.entity_name, otherwise just use var.role_name as is
  role_name = length(regexall(".*%s.*", var.role_name)) > 0 ? format(var.role_name, var.entity_name) : var.role_name
}
