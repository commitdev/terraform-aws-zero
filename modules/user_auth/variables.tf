variable "project" {
  description = "The name of the project"
}

variable "auth_namespace" {
  description = "Namespace to use for auth resources"
  type        = string
  default     = "user-auth"
}

variable "k8s_local_exec_context" {
  description = "Custom resource (Oathkeeper Rules are created using local-exec with kubectl), if not specified it will target your current context from kubeconfig"
  type        = string
  default     = ""
}

variable "backend_service_domain" {
  description = "Domain of the backend service"
  type        = string
}

variable "frontend_service_domain" {
  description = "Domain of the frontend"
  type        = string
}

variable "user_auth_mail_from_address" {
  description = "Mail from the user management system will come from this address"
  type        = string
  default     = ""
}

variable "jwks_secret_name" {
  description = "The name of a secret in the auth namespace containing a JWKS file for Oathkeeper"
  type        = string
}

variable "whitelisted_return_urls" {
  description = "URLs that can be redirected to after completing a flow initialized with the return_to parameter"
  type        = list(string)
  default     = []
}

variable "cookie_sigining_secret_key" {
  description = "Default secret key for signing cookies"
  type        = string
  sensitive   = true
}