output "role" {
  value       = aws_iam_role.the_role
  description = "The IAM role that can read the specified SSM Parameter Store parameters."
}
