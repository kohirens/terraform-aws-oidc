# Terraform AWS OIDC

Add OIDC providers to an AWS account.

## Status

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/kohirens/terraform-aws-oidc-circleci/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/kohirens/terraform-aws-oidc-circleci/tree/main)

## Example

```terraform
module "circleci_oidc" {
  source = "https://github.com/kohirens/terraform-aws-oidc"
  circleci = {
    organization_name = "myorg"
    organization_id   = "aaaaaaaa-0000-1111-2a22-a33333333333"

    projects = {
      "project-1-name" = {
        id = "aaaaaaaa-0000-1111-2a22-b44444444444"
        statements = list({
          actions   = ["*"]
          resources = ["*"]
        })
      }
    }
  }
}
```