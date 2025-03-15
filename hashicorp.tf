locals {
  hashicorp_name = "Hashicorp"

  # transform a map of CircleCI provider configs into a format that can be used with AWS resources.
  hashicorp_configs = { for org, projects in var.hashicorp :
    org => {
      client_id_list = [var.hashicorp_oidc_audience] # because the provider URL requires the organization ID, making it unique, you cannot provide multiple client IDs.
      iam_roles = flatten({ for p_name, prj in projects :
        p_name => { for ws_name, ws in prj : ws_name => {
          assume_role_policy = templatefile("${path.module}/files/trust-policy-hashicorp.tftpl.json", {
            account_id    = local.account_id
            oidc_provider = var.hashicorp_oidc_domain
            oidc_aud      = var.hashicorp_oidc_audience
            org           = org
            project       = p_name
            workspace     = ws_name
            run_phase     = ws.run_phase
          })
          path       = "/OIDC/${local.hashicorp_name}/${org}/${p_name}"
          statements = [{ actions = ws.actions, resources = ws.resources }]
        } }
      })[0]
      provider_url = "https://${var.hashicorp_oidc_domain}"
    }
  }
}
