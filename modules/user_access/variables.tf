variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (stage/prod)"
}

variable "roles" {
  description = "Roles to create with associated aws policies"
  type = list(object({
    name       = string
    aws_policy = string
  }))
}

variable "users" {
  description = "Users to create with associated roles, mapping to the ones defined in the roles variable"
  type = list(object({
    name  = string
    roles = list(string)
  }))
}
