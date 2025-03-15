locals {
  circleci_name = "Circleci"

  # transform a map of CircleCI provider configs into a format that can be used with AWS resources.
  circleci_configs = { for org, val in var.circleci :
    org => {
      client_id_list = [val.id] # because the provider URL requires the organization ID, making it unique, you cannot provide multiple client IDs.
      iam_roles = {for p_name, prj in val.projects : p_name => {
        path = "/OIDC/${local.circleci_name}/${org}/"
        assume_role_policy = templatefile("${path.module}/files/circleci-trust-policy.tftpl.json", {
          account_id      = local.account_id
          domain          = val.domain
          organization_id = val.id
          project_id      = prj.id
        })
      }}
      provider_url = "https://${val.domain}/org/${val.id}"
    }
  }
}
