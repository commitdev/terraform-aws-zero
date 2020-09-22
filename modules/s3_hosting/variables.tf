variable "project" {
  description = "The name of the project, mostly for tagging"
}

variable "environment" {
  description = "The environment (dev/stage/prod)"
}

variable "domain" {
  description = "Domain to host content for. This will be the name of the bucket"
  type        = string
}

variable "aliases" {
  description = "Additional domains that this cloudfront distribution will serve traffic for"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ARN of the certificate to use for this cloudfront distribution"
  type        = string
}

variable "certificate_validation" {
  description = "Id of the certificate validation record for the provided cert. Used to create a dependency so we don't use the cert before it is ready"
  type        = string
}

variable "route53_zone_id" {
  description = "ID of the Route53 zone to create a record in"
  type        = string
}

variable "cf_signed_downloads" {
  type        = bool
  description = "Enable Cloudfront signed URLs"
  default     = false
}
