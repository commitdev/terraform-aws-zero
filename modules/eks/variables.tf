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
  type = map(object({
    instance_types     = list(string)
    asg_min_size       = string
    asg_max_size       = string
    use_spot_instances = bool
    ami_type           = string
  }))
  description = "Map of maps of EKS node group config where keys are node group names"
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
