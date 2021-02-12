variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (development/staging/production)"
}

variable "cache_store" {
  description = "Cache store - redis or memcached"
  type        = string
  validation {
    condition     = contains(["redis", "memcached"], var.cache_store)
    error_message = "Allowed values for cache_store are \"redis\", \"memcached\"."
  }
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
}

variable "subnet_ids" {
  description = "Subnets IDs"
  type        = list(string)
}

variable "instance_type" {
  description = "Elastic cache instance type"
  type        = string
  default     = "cache.t2.micro"
}

variable "cluster_size" {
  type        = number
  default     = 1
  description = "Number of nodes in cluster"
}

variable "availability_zones" {
  description = "Availability zone IDs"
  type        = list(string)
  default     = []
}

#variable "zone_name" {
#  description = "route53 zone for CNAME records to be created"
#  type        = string
#}
#
variable "security_groups" {
  description = "The ID of the security group created by default on Default VPC creation"
  type        = list(string)
}

variable "redis_engine_version" {
  description = "Engine version"
  type        = string
  default     = "5.0.6"
}

variable "memcached_engine_version" {
  description = "Engine version"
  type        = string
  default     = "1.5.16"
}

variable "redis_family" {
  description = "Redis family"
  type        = string
  default     = "redis5.0"
}

variable "redis_transit_encryption_enabled" {
  description = "Enable TLS for redis"
  type        = bool
  default     = true
}
