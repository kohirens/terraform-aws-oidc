output "iam_oidc_arns" {
  description = "ARNs of IAM OpenID Connect providers"
  value       = module.iam_oidc_providers.iam_oidc_arns
}

output "iam_role_arns" {
  description = "OIDC provider IAM Roles"
  value       = module.iam_oidc_providers.iam_role_arns
}
