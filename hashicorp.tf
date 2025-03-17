locals {
  hashicorp_name = "Hashicorp"

  # transform a map of CircleCI provider configs into a format that can be used with AWS resources.
  hashicorp_idp = length(var.hashicorp) > 0 ? {
    "hashicorp" = {
      client_id_list = [var.hashicorp_oidc_audience]
      provider_url   = "https://${var.hashicorp_oidc_domain}"
      iam_roles = flatten([for o_name, o in var.hashicorp :
        [for p_name, p in o :
          { for w_name, w in p : "${p_name}-${w_name}" => {
            assume_role_policy = templatefile("${path.module}/files/trust-policy-hashicorp.tftpl.json", {
              account_id    = local.account_id
              oidc_provider = var.hashicorp_oidc_domain
              oidc_aud      = var.hashicorp_oidc_audience
              org           = o_name
              project       = p_name
              workspace     = w_name
              run_phase     = w.run_phase
            })
            organization = o_name
            path         = "/OIDC/${local.hashicorp_name}/${o_name}"
            statements   = [{ actions = w.actions, resources = w.resources }]
          } }
        ]
      ])
    }
  } : {}
}
