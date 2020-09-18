variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (development/staging/production)"
}

variable "iam_roles" {
   type        = list(tuple([string, string]))
   description = "IAM role list with policy"
}

variable "iam_users" {
   type        = list(tuple([string, list(string)]))
   description = "IAM user list with multiple roles assigned"
}
