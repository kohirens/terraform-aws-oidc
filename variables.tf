variable "client_id_list" {
  description = "Usually this is the organization ID of some kind from the provider. Check your Provider OIDC documentation."
  type        = list(string)
}

variable "circleci" {
  default     = null
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

variable "provider_url" {
  description = "URL to the Provider"
  type        = string
}
