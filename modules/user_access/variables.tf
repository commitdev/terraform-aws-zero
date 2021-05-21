variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (stage/prod)"
}

variable "roles" {
  description = "Roles to create with associated aws and k8s policies"
  type = list(object({
    name         = string
    aws_policy   = string
    k8s_policies = list(map(list(string)))
  }))
}

variable "users" {
  description = "Users to create with associated roles, mapping to the ones defined in the roles variable"
  type = list(object({
    name  = string
    roles = list(string)
  }))
}

variable "assumerole_account_ids" {
  description = "AWS account IDs that will be allowed to assume the roles we are creating. If left blank, the AWS account you are using will be used"
  type        = list(string)
  default     = []
}
