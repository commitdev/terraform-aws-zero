variable "project" {
  description = "The name of the project, mostly for tagging"
}

variable "environment" {
  description = "The environment (stage/prod)"
}

variable "region" {
  description = "The AWS region to create resources in"
}

variable "kubernetes_cluster_name" {
  description = "Kubernetes cluster name used to associate with subnets for auto LB placement"
}

variable "enable_nat_gateway" {
  description = "Create NAT gateway(s) to allow private subnets to route traffic out to the public internet. If this is set to false, it will create a NAT instance instead. This can be useful in non-production environments to reduce cost, though in some cases it may lead to network instability or lower throughput."
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use single nat-gateway instead of nat-gateway per subnet"
  type        = bool
}

variable "nat_instance_types" {
  description = "Candidates of instance type for the NAT instance"
  type        = list(any)
  default     = ["t3.nano", "t3a.nano"]
}

