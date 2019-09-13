output "arn" {
  value       = aws_iam_role.the_role.arn
  description = "The ARN corresponding to the IAM role to be used for reading certificate data for the specified hostname"
}
