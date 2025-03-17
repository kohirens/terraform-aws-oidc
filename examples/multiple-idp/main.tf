module "idp_oidc_setup" {
  source = "../.."

  circleci = {
    "Organization-1" = {
      id     = "00000000-0000-0000-0000-000000000001"
      domain = "oidc.circleci.com"
      projects = {
        "circleci-project1" = {
          id = "00000000-0000-0000-0000-00000000000a"
          statements = [
            {
              actions   = ["*"]
              resources = ["*"]
            }
          ]
        }
      }
    }
    "Organization-2" = {
      id     = "00000000-0000-0000-0000-000000000002"
      domain = "oidc.circleci.com"
      projects = {
        "circleci-project1" = {
          id = "00000000-0000-0000-0000-00000000000b"
          statements = [
            {
              actions   = ["*"]
              resources = ["*"]
            }
          ]
        }
      }
    }
  }

  hashicorp = {
    "Organization-1" = {
      "DefaultProject" = {
        "*" = {
          actions   = ["s3:*", "ec2:*", "iam:*"]
          resources = ["*"]
          run_phase = "*"
        },
        "workspace1" = {
          actions   = ["s3:*", "ec2:*"]
          resources = ["*"]
          run_phase = "*"
        }
      }
    }
  }

  github = {
    "Organization-1" = {
      repos = {
        "*" = {
          statements = [{ actions = ["*"], resources = ["*"] }]
        }
      }
    }
    "Other-Organization" = {
      repos = {
        "printing-press-1" = {
          statements = [{ actions = ["*"], resources = ["*"] }]
        }
      }
    }
  }
}