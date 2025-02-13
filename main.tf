data "aws_caller_identity" "current" {}

locals {
  provider_url = "https://${var.provider_domain}/org/${var.organization_id}"
  account_id   = data.aws_caller_identity.current.account_id
}

data "tls_certificate" "oidc" {
  url = local.provider_url
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url = local.provider_url
  # because the provider URL requires the organization, making it unique, you can't provide multiple client IDs.
  client_id_list  = [var.organization_id]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "permissions" {
  for_each = var.project_aws_permissions

  dynamic "statement" {
    for_each = each.value.statements
    content {
      actions   = statement.value.actions
      effect    = "Allow"
      resources = statement.value.resources
    }
  }
}

resource "aws_iam_role" "role" {
  for_each = var.project_aws_permissions

  name        = "circleci-${var.organization}-${each.key}"
  description = "Role for CircleCI project ${each.key} of the ${var.organization} org"

  assume_role_policy = templatefile("${path.module}/trust-policy.tftpl.json", {
    account_id      = local.account_id
    provider_domain = var.provider_domain
    org_id          = var.organization_id
    project_id      = each.value.id
  })
}

resource "aws_iam_role_policy" "role" {
  for_each = data.aws_iam_policy_document.permissions
  role     = aws_iam_role.role[each.key].name
  name     = var.organization
  policy   = each.value.json
}
