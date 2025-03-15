locals {
  circleci_name = "Circleci"

  # build a map of provider URLs and Client IDs for CircleCI organizations.
  circleci_configs = { for org, val in var.circleci :
    org => {
      client_id_List = [val.id]
      iam_roles = [for p_name, prj in val.projects : {
        path = "/OIDC/${local.circleci_name}/${org}/"
        assume_role_policy = templatefile("${path.module}/trust-policy.tftpl.json", {
          account_id      = local.account_id
          domain          = val.domain
          organization_id = val.id
          project_id      = prj.id
        })
      }]
      provider_url = "https://${val.domain}/org/${val.id}"
    }
  }
}
