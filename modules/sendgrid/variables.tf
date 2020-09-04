variable "zone_name" {
  description = "route53 zone for CNAME records to be created"
  type        = string
}

variable "sendgrid_api_key_secret_name" {
  description = "name of the secret in AWS secret manager that contains the sendgrid API key"
}

variable "sendgrid_domain_prefix" {
  description = "prefix for mailing domain used by sendgrid"
  type        = string
  default     = "mail."
}
