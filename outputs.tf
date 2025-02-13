output "iam_role_arns" {
  value = [for v in aws_iam_role.role : v.arn]
}
