output "role_arn" {
  value       = module.ssm_role.arn
  description = "The ARN corresponding to the IAM role to be used for reading SSM params for site.example.com"
}
