# Used to get this account ID we're deploying to.
data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

module "oidc" {
  source = "./modules/oidc"

  for_each          = local.circleci_configs
  client_id_list    = each.value.client_id_list
  iam_roles         = each.value.iam_roles
  organization_name = each.key
  provider_name     = local.circleci_name
  provider_url      = each.value.provider_url
}
