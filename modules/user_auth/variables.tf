variable "name" {
  description = "The name to create user-auth components(kratos/oathkeeper), must be unique in the cluster for helm-resources "
  type        = string
}

variable "create_namespace" {
  description = "Whether to create the auth namespace(defaults to true), otherwise just references the namespace"
  type        = bool
  default     = true
}

variable "auth_namespace" {
  description = "Namespace to use for auth resources"
  type        = string
  default     = "user-auth"
}

variable "kratos_secret_name" {
  description = "Secret name for kratos to access Database credentials, created from pre-k8s script"
  type        = string
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

variable "jwks_content" {
  description = "The content of a JWKS file for Oathkeeper"
  type        = string
  sensitive   = true
}

variable "whitelisted_return_urls" {
  description = "URLs that can be redirected to after completing a flow initialized with the return_to parameter"
  type        = list(string)
  default     = []
}

variable "cookie_signing_secret_key" {
  description = "Default secret key for signing cookies"
  type        = string
  sensitive   = true
}

variable "kubectl_extra_args" {
  description = "Arguments that will be passed to kubectl when using the local executor in cases where the terraform k8s support is not enough"
  type        = string
}

variable "external_secret_backend" {
  description = "The backend external-secrets will pull secret data from to create a corresponding secret in kubernetes. If empty, external-secrets will not be used. You'll need to make sure the secret is created manually."
  type        = string
  default     = "secretsManager"
}

variable "external_secret_name" {
  description = "Name of a secret in an external secrets backend that contains the content to pull into a kubernetes secret for Kratos to use"
  type        = string
}

variable "kratos_values_override" {
  description = "a map of parameters to override the kratos-values.yml"
  type        = map(any)
  default     = {}
}

variable "oathkeeper_values_override" {
  description = "a map of parameters to override the oathkeeper-values.yml"
  type        = map(any)
  default     = {}
}
