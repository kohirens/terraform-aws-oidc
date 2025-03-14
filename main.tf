data "tls_certificate" "oidc" {
  url = var.provider_url
}

resource "aws_iam_openid_connect_provider" "oidc" {
  url = var.provider_url
  # because the provider URL requires the organization, making it unique, you can't provide multiple client IDs.
  client_id_list  = var.client_id_list
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
}
