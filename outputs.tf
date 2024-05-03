output "policy" {
  description = "The IAM policy that can read the specified SSM Parameter Store parameters."
  value       = aws_iam_policy.ssm_policy
}

output "role" {
  description = "The IAM role that can read the specified SSM Parameter Store parameters."
  value       = aws_iam_role.ssm_role
}
