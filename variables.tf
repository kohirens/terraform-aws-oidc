variable "client_id_list" {
  description = "Usually this is the organization ID of some kind from the provider. Check your Provider OIDC documentation."
  type        = list(string)
}

variable "provider_url" {
  description = "URL to the Provider"
  type        = string
}
