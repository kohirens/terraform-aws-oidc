variable "client_id_list" {
  description = "Usually this is the organization ID of some kind from the provider. Check your Provider OIDC documentation."
  type        = list(string)
}

variable "iam_roles" {
  description = ""
  type = list(map(object({
    organization       = string
    path               = string
    assume_role_policy = string # a.k.a trust policy
    statements = list(object({
      actions   = list(string)
      resources = list(string)
    }))
  })))
}

variable "provider_name" {
  description = "Name of the Provider"
  type        = string
}

variable "provider_url" {
  description = "URL to the Provider"
  type        = string
}