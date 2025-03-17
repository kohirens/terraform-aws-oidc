# Used to get this account ID we're deploying to.
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  idp        = merge(local.circleci_idp, local.hashicorp_idp, local.github_idp)
}

module "oidc_providers" {
  source         = "./modules/oidc"
  for_each       = local.idp
  client_id_list = each.value.client_id_list
  iam_roles      = each.value.iam_roles
  provider_name  = each.key
  provider_url   = each.value.provider_url
}
