variable "client_id_list" {
  description = "Usually this is the organization ID of some kind from the provider. Check your Provider OIDC documentation."
  type        = list(string)
}

variable "organization_name" {
  description = "Name of the organization"
  type        = string
}

variable "provider_name" {
  description = "Name of the Provider"
  type        = string
}

variable "provider_url" {
  description = "URL to the Provider"
  type        = string
}

variable "iam_roles" {
  description = "IAM Roles to for the Provider to assume"
  type = map(object({
    path               = string
    assume_role_policy = string
    statements = list(object({
      actions   = list(string)
      resources = list(string)
    }))
  }))
}