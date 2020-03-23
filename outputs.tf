output "policy" {
  value       = aws_iam_policy.ssm_policy
  description = "The IAM policy that can read the specified SSM Parameter Store parameters."
}

output "role" {
  value       = aws_iam_role.ssm_role
  description = "The IAM role that can read the specified SSM Parameter Store parameters."
}
