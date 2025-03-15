data "tls_certificate" "oidc" {
  url = var.provider_url
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url = var.provider_url
  # because the provider URL requires the organization, making it unique, you can't provide multiple client IDs.
  client_id_list  = var.client_id_list
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
}

# Used to get this account ID we're deploying to.
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}
