# Terraform AWS OIDC CircleCI

Add CircleCI OIDC as an IAM provider to an AWS account.

## Status

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/kohirens/terraform-aws-oidc-circleci/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/kohirens/terraform-aws-oidc-circleci/tree/main)


## Example

```terraform
module "iam_oidc_provider" {
  source = "https://github.com/kohirens/terraform-aws-oidc-circleci"

  organization    = "myorg"
  organization_id = "aaaaaaaa-0000-1111-2a22-a33333333333"

  project_aws_permissions = {
    "learn-terraform-circleci" = {
      id = "aaaaaaaa-0000-1111-2a22-b44444444444"
      statements = {
        "statement1" = {
          actions   = ["*"]
          resources = ["*"]
        }
      }
    }
  }
}
```