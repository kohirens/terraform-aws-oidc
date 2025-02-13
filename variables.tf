variable "provider_domain" {
  default     = "oidc.circleci.com"
  description = "CircleCI OIDC provider domain"
  type        = string
}

variable "organization_id" {
  description = "The organization ID"
  type        = string

  validation {
    condition     = length(var.organization_id) >= 3
    error_message = "invalid organization ID"
  }
}

variable "organization" {
  description = "The name pf the organization"
  type        = string

  validation {
    condition     = length(var.organization) >= 3
    error_message = "invalid organization name"
  }
}

variable "project_aws_permissions" {
  description = "A map of circleCI projects and their corresponding IDs and desired IAM actions and resources"

  type = map(object({
    id = string
    statements = map(object({
      actions   = list(string)
      resources = list(string)
    }))
  }))
}
