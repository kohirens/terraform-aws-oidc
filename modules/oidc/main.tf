data "aws_caller_identity" "current" {}

data "tls_certificate" "oidc" {
  url = var.provider_url
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url             = var.provider_url
  client_id_list  = var.client_id_list
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "role" {
  for_each = var.iam_roles

  name                  = "OIDC-${var.provider_name}-${var.organization_name}-${each.key}"
  path                  = each.value.path # see https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names
  force_detach_policies = true
  description           = "Role for OIDC ${var.provider_name} project ${each.key} of the ${var.organization_name} org"
  assume_role_policy    = each.value.assume_role_policy
}
