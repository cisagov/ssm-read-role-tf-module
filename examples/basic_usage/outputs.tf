output "policy" {
  value       = module.ssm_role.policy
  description = "The IAM policy that can read the specified SSM Parameter Store parameters for site.example.com."
}

output "role" {
  value       = module.ssm_role.role
  description = "The IAM role that can read the specified SSM Parameter Store parameters for site.example.com."
}
