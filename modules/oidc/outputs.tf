output "iam_oidc_arn" {
  description = "ARN of an IAM OpenID Connect provider"
  value = aws_iam_openid_connect_provider.oidc.arn
}

output "iam_role_arns" {
  description = "OIDC provider IAM Roles"
  value       = [for v in aws_iam_role.oidc : v.arn]
}

