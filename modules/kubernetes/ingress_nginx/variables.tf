variable "chart_version" {
  description = "The version of helm chart to use."
  type        = string
  default     = "3.25.0"
}

variable "replica_count" {
  description = "Number of replicas of the ingress controller to create. Should be 2 or more in production."
  type        = number
  default     = 2
}

variable "additional_configmap_options" {
  description = "Map of additional options to add to the configmap. Merged into a default set defined by the module."
  type        = map(string)
  default     = {}
}

variable "namespace" {
  description = "Namespace to create the ingress in."
  type        = string
  default     = "ingress-nginx"
}

variable "enable_metrics" {
  description = "Enable prometheus metrics support, including adding a ServiceMonitor."
  type        = bool
}

variable "use_network_load_balancer" {
  description = "Use an AWS NLB to load balance traffic to the cluster. Recommended. If false, will create a Classic Load Balancer."
  type        = bool
  default     = true
}
variable "connection_idle_timeout" {
  description = "The amount of time the load balancer will keep an idle connection open for. The value of nginx upstream-keepalive-timeout will also be set to this value + 5. If it were shorter than the LB timeout it could cause intermittent 502s."
  type        = number
  default     = 55
}
