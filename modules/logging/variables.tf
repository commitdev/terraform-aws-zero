variable "project" {
  description = "The name of the project, mostly for tagging"
}

variable "environment" {
  description = "The environment (stage/prod)"
}

variable "vpc_id" {
  description = "ID of the VPC to create this cluster in"
}

variable "elasticsearch_version" {
  description = "Version of elasticsearch to use"
}

variable "security_groups" {
  description = "Security groups to allow access from"
  type        = list(string)
}

variable "subnet_ids" {
  description = "IDs of the subnets to put nodes in. The number of subnets here controls the number of nodes in the cluster, which must be a multiple of this number"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance type for nodes"

  validation {
    condition     = can(regex("^[[:alpha:]][[:digit:]][[:alpha:]]?\\..*\\.elasticsearch$", var.instance_type))
    error_message = "The instance_type variable must contain a valid elasticsearch instance type."
  }
}

variable "create_service_role" {
  description = "Set this to false if you already have an existing Elasticsearch cluster in this AWS account"
  type        = bool
}

variable "instance_count" {
  description = "Number of nodes in the cluster. Must be a multiple of the number of"
  type        = number
}

variable "ebs_volume_size_in_gb" {
  description = "Size of EBS volume (in GB) to attach to *each* of the nodes in the cluster. The maximum size is limited by the size of the instance"
  type        = number
}

variable "ebs_volume_type" {
  description = "Storage type of EBS volumes for data"
  type        = string
  default     = "gp2"
}
variable "ebs_iops" {
  type        = number
  default     = 0
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
}

variable "enable_cluster_logging" {
  description = "If enabled, sends the logs from the elasticsearch cluster to Cloudwatch"
  type        = bool
  default     = false
}

variable "kibana_subdomain_name" {
  description = "The name of the subdomain for Kibana in the DNS zone (_e.g._ `kibana`, `ui`, `ui-es`, `search-ui`, `kibana.elasticsearch`)"
  type        = string
  default     = "kibana"
}

variable "elasticsearch_enforce_https" {
  description = "Set this to true to disallow unencrypted connections to Elasticsearch on port 80. Disabled by default as we are using kubernetes external services as user-friendly names to allow developers to connect to the cluster through the VPN. This would break if using HTTPS due to certificate issues."
  type        = bool
  default     = false
}
