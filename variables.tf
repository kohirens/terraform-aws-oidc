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
