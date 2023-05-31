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

variable "eks_node_groups" {
  type        = any
  description = "Map of maps of EKS node group config where keys are node group names. See the readme for details."
}

variable "iam_account_id" {
  description = "Account ID of the current IAM user"
}

variable "addon_vpc_cni_version" {
  description = "Version of the VPC CNI to install. If empty you will need to upgrade the CNI yourself during a cluster version upgrade"
  type        = string
  default     = ""
}

variable "addon_kube_proxy_version" {
  description = "Version of kube proxy to install. If empty you will need to upgrade kube proxy yourself during a cluster version upgrade"
  type        = string
  default     = ""
}

variable "addon_coredns_version" {
  description = "Version of CoreDNS to install. If empty you will need to upgrade CoreDNS yourself during a cluster version upgrade"
  type        = string
  default     = ""
}

variable "force_old_cluster_iam_role_name" {
  description = "Compatibility fix - If your cluster was created using a version of this module earlier than 0.4.3, this should be set to true. If the wrong value is set, you may see kubernetes connection issues when running terraform"
  type        = bool
  default     = false
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = []
}

variable "cluster_log_retention_in_days" {
  description = "Number of days to retain log events on CloudWatch logs from `cluster_enabled_log_types`"
  type        = number
  default     = 90
}

variable "node_group_name_as_prefix" {
  description = "Use Node Group name as a prefix ? This allow to change instance types."
  type        = bool
  default     = false
}
