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
  description = "Use an AWS NLB to load balance traffic to the cluster. If false, will create a Classic Load Balancer. NLB is not recommended at this time due to some connection issues."
  type        = bool
  default     = false
}
variable "connection_idle_timeout" {
  description = "The amount of time the load balancer will keep an idle connection open for. The value of nginx upstream-keepalive-timeout will also be set to this value + 5. If it were shorter than the LB timeout it could cause intermittent 502s."
  type        = number
  default     = 55
}

variable "apply_pod_anti_affinity" {
  description = "If true, will instruct k8s to try not to schedule multiple nginx controller pods on the same node if there are other nodes available. This helps redundancy, as it is less likely all your controller pods are on the same node, which could cause problems if that node were terminated unexepectedly."
  type        = bool
  default     = true
}

variable "use_proxy_protocol" {
  description = "If true, will enable proxy protocol support between the Load Balancer and the nginx ingress controller. This allows nginx to know the IP of the client when using an ELB."
  type        = bool
  default     = true
}

variable "external_traffic_policy" {
  description = "The external traffic policy to apply to the ingress service. Cluster will open a valid NodePort on all nodes even if they aren't running an ingress pod and kubernetes will handle sending the traffic to the correct pod. Local will only have valid NodePorts on the nodes running ingress pods."
  type        = string
  default     = "Cluster"

  validation {
    condition     = (var.external_traffic_policy == "Local" || var.external_traffic_policy == "Cluster")
    error_message = "Invalid value for external_traffic_policy. Valid values are Local or Cluster."
  }
}
