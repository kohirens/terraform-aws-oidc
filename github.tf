locals {
  github_name = "GitHub"

  # transform a map GitHub repos to IAM permissions.
  github_idp = length(var.github) > 0 ? { "github" = {
    client_id_list : [var.github_oidc_audience]
    provider_url : var.github_provider_url
    iam_roles = flatten([for o_name, o in var.github :
      [for r_label, repos in o :
        { for r_name, r in repos : r_name => {
          assume_role_policy = templatefile("${path.module}/files/trust-policy-github.tftpl.json", {
            account_id        = local.account_id
            organization_name = o_name
            repo_name         = r_name
          })
          organization = o_name
          path         = "/OIDC/${local.github_name}/${o_name}/"
          statements   = r.statements
          }
        }
    ]])
    }
  } : {}
}
