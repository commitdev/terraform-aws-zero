variable "sendgrid_api_key_secret_name" {
  description = "api_key for sendgrid api, used to authenticate domain once route53 records are created"
}

variable "zone_name" {
  description = "route53 zone for CNAME records to be created"
  type = string
}

variable "cnames" {
  description = "list of CNAME records to be created for domain authentication"
  type  = list(tuple([string, string]))
  default = []
}

variable "domain_id" {
  description = "domain_id created by Sendgrid api, unique identifier from sendgrid"
  type  = string
}
