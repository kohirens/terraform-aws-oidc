locals {
  circleci_name = "Circleci"

  # transform a map of CircleCI provider configs into a format that can be used with AWS resources.
  // The provider URL includes the organization; making it unique.
  circleci_idp = { for o_name, o in var.circleci :
    "circleci-${o.id}" => {
      client_id_list : [o.id]
      provider_url = "https://${o.domain}/org/${o.id}"
      iam_roles = [
        { for p_name, p in o.projects : p_name => {
          assume_role_policy = templatefile("${path.module}/files/circleci-trust-policy.tftpl.json", {
            account_id      = local.account_id
            domain          = o.domain
            organization_id = o.id
            project_id      = p.id
          })
          organization = o_name
          path         = "/OIDC/${local.circleci_name}/${o_name}/"
          statements   = p.statements
          }
        }
      ]
    }
  }
}
