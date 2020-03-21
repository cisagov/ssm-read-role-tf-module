output "role" {
  value       = module.ssm_role
  description = "The IAM role that can read the specified SSM Parameter Store parameters for site.example.com."
}
