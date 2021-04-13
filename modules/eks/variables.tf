variable "project" {
  description = "Name of the project"
}

variable "environment" {
  description = "The environment (stage/prod)"
}

variable "cluster_name" {
  description = "Name to be given to the EKS cluster"
}

variable "cluster_version" {
  description = "EKS cluster version number to use. Incrementing this will start a cluster upgrade"
}

variable "private_subnets" {
  description = "VPC subnets for the EKS cluster"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID for EKS cluster"
}

variable "worker_instance_types" {
  description = "Instance types to use for the EKS workers. When use_spot_instances is true you may provide multiple instance types and it will diversify across the cheapest pools"
  type        = list(string)
  default     = []
}

variable "worker_ami_type" {
  description = "AMI type for the EKS worker instances. The default will be the normal image. Other possibilities are AL2_x86_64_GPU for gpu instances or AL2_ARM_64 for ARM instances"
  type        = string
  default     = "AL2_x86_64"
}
variable "use_spot_instances" {
  description = "Enable use of spot instances instead of on-demand. This can provide significant cost savings and should be stable due to the use of the termination handler, but means that individuial nodes could be restarted at any time. May not be suitable for clusters with long-running workloads"
  type        = bool
  default     = false
}

variable "worker_asg_min_size" {
  description = "Minimum number of instances for the EKS ASG"
}

variable "worker_asg_max_size" {
  description = "Maximum number of instances for the EKS ASG"
}

variable "iam_account_id" {
  description = "Account ID of the current IAM user"
}

variable "iam_role_mapping" {
  type = list(object({
    iam_role_arn  = string
    k8s_role_name = string
    k8s_groups    = list(string)
  }))
  description = "List of mappings of AWS Roles to Kubernetes Groups"
}
