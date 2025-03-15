output "iam_oidc_arn" {
  description = "ARN of an IAM OpenID Connect provider"
  value       = module.oidc.iam_role_arns
}

output "iam_role_arns" {
  description = "OIDC provider IAM Roles"
  value       = module.oidc.iam_oidc_arn
}

