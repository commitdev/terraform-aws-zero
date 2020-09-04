variable "zone_name" {
  description = "route53 zone for CNAME records to be created"
  type = string
}

variable "sendgrid_api_key_secret_name" {
  description = "api_key for sendgrid api, used to authenticate domain once route53 records are created"
}

variable "sendgrid_domain_prefix" {
  description = "prefix for mailing domain used by sendgrid"
  type = string
  default = "mail."
}
