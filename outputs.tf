output "iam_oidc_arns" {
  description = "ARNs of IAM OpenID Connect providers"
  value       = [for k, p in module.oidc_providers : p.iam_oidc_arn]
}

output "iam_role_arns" {
  description = "OIDC provider IAM Roles"
  value       = [for k, p in module.oidc_providers : p.iam_role_arns]
}

