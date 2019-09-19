output "arn" {
  value       = aws_iam_role.the_role.arn
  description = "The ARN corresponding to the IAM role to be used for reading SSM parameters for the specified hostname"
}
