variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (development/staging/production)"
}

variable "roles" {
  type = list(object({
    name   = string
    policy = string
  }))
  description = "Role list with policy"
}

variable "users" {
  type = list(object({
    name  = string
    roles = list(string)
  }))
  description = "User list with multiple roles granted"
}
