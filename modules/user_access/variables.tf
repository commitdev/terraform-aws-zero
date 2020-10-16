variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (development/staging/production)"
}

variable "roles" {
  type = list(object({
    name         = string
    aws_policy   = string
    k8s_policies = list(map(list(string)))
    k8s_groups   = list(string)
  }))
  description = "Role list with policies"
}

variable "users" {
  type = list(object({
    name  = string
    roles = list(string)
  }))
  description = "User list with roles"
}
