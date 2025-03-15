locals {
  github_name = "GitHub"

  # transform a map GitHub repos to IAM permissions.
  github_configs = { for org, val in var.github :
    org => {
      client_id_list = [var.github_oidc_audience]
      iam_roles = { for repo_name, repo in val.repos : repo_name => {
        assume_role_policy = templatefile("${path.module}/files/trust-policy-github.tftpl.json", {
          account_id        = local.account_id
          organization_name = org
          repo_name         = repo_name
        })
        path       = "/OIDC/${local.github_name}/${org}/"
        statements = repo.statements
      } }
      provider_url = var.github_provider_url
    }
  }
}
