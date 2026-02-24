# Terraform AWS OIDC

Add OIDC providers to an AWS account.

## Status

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/kohirens/terraform-aws-oidc/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/kohirens/terraform-aws-oidc/tree/main)

## How To Use

### github Variable

Each key under the `github` map variable will be treated as an organization.

Add the module composition to your IaC like so:

```terraform
module "iam_oidc_providers" {
  source = "git@github.com:kohirens/terraform-aws-oidc?ref=0.1.0"

  github = {
    "<github-organization>" = {
      repos = {
        "<repository-name>" = {
          statements = [{
            actions = ["<AWS-action>", "..."],
            resources = ["<AWS-ARN>", "..."]
          }]
        }
      }
    }
  }
}
```

* `<github-organization>` - The name of a GitHub organization.
* `<repository-name>` - The name of the repository you wish to grant AWS
  permissions. The `*` character can be used to grant all repositories
  shared permissions.
* `<AWS-action>` - A list of strings representing AWS actions. The `*` character
  can be used to represent all AWS actions.
* `<AWS-ARN>` - A list of strings representing AWS resource names (ARNs). The
  `*` character can be used to grant all actions on all resources.

## Example of "Least Privilege"

Only grant a single repository permissions to a single S3 bucket under
the **_octocat_** organization:

```terraform
module "iam_oidc_providers" {
  source = "git@github.com:kohirens/terraform-aws-oidc?ref=0.1.0"

  github = {
    "octocat" = {
      repos = {
        "space-pics" = {
          statements = [{
            actions = ["s3:GetObject","s3:PutObject","s3:DeleteObject"],
            resources = ["arn:aws:s3:::space-pics-000000000000"]
          }]
        }
      }
    }
  }
}
```

## Example of Administrator

For all repositories under the octocat organization, allow GitHub Actions to
execute all AWS actions on any AWS resource:

```terraform
module "iam_oidc_providers" {
  source = "git@github.com:kohirens/terraform-aws-oidc?ref=0.1.0"

  github = {
    "octocat" = {
      repos = {
        "*" = { # All repositories will be granted the following permissions.
          statements = [{
            actions = ["*"],
            resources = ["*"]
          }]
        }
      }
    }
  }
}
```

NOTE: We recommend using the least privilege approach over administrative in
production environments.

This is the similar for the other variables `circleci` and `hashicorp`. Please
review the [examples] for more details.

---

[examples]: examples
