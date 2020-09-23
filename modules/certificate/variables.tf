variable "zone_name" {
  description = "Domains of the Route53 hosted zone"
  type        = string
}

variable "domain_name" {
  description = "Domain to create an ACM Cert for"
  type        = string
}

variable "alternative_names" {
  description = "Alternative names to allow for this certificate"
  type        = list(string)
  default     = []
}
