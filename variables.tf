variable "circleci" {
  default     = {}
  description = "Grant a Circle CI organization's projects access to AWS resources."
  type = map(object({
    domain = optional(string, "oidc.circleci.com")
    id     = string
    projects = map(object({
      id = string
      statements = list(object({
        actions   = list(string)
        resources = list(string)
      }))
    }))
  }))
}

variable "hashicorp" {
  default     = {}
  description = "Map HCP Project names containing a list representing workspaces to assign AWS IAM permissions"
  type = map(
    map(
      map(object({
        actions     = list(string)
        description = optional(string, "")
        resources   = list(string)
        run_phase   = string
      }))
    )
  )
}

variable "hashicorp_oidc_domain" {
  default     = "app.terraform.io"
  description = "The FQDN of the HCP Terraform OIDC provider"
  type        = string
}
variable "hashicorp_oidc_audience" {
  default     = "aws.workload.identity"
  description = "The list of client IDs; defaults to audience in HCP Terraform for AWS."
  type        = string
}
