# kubernetes/ingress

Create and configure an Nginx Ingress Controller in a Kubernetes cluster.

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_configmap\_options | Map of additional options to add to the configmap. Merged into a default set defined by the module. | `map(string)` | `{}` | no |
| apply\_pod\_anti\_affinity | If true, will instruct k8s to try not to schedule multiple nginx controller pods on the same node if there are other nodes available. This helps redundancy, as it is less likely all your controller pods are on the same node, which could cause problems if that node were terminated unexepectedly. | `bool` | `true` | no |
| chart\_version | The version of helm chart to use. | `string` | `"3.34.0"` | no |
| connection\_idle\_timeout | The amount of time the load balancer will keep an idle connection open for. The value of nginx upstream-keepalive-timeout will also be set to this value + 5. If it were shorter than the LB timeout it could cause intermittent 502s. | `number` | `55` | no |
| enable\_metrics | Enable prometheus metrics support, including adding a ServiceMonitor. | `bool` | n/a | yes |
| external\_traffic\_policy | The external traffic policy to apply to the ingress service. Cluster will open a valid NodePort on all nodes even if they aren't running an ingress pod and kubernetes will handle sending the traffic to the correct pod. Local will only have valid NodePorts on the nodes running ingress pods. | `string` | `"Cluster"` | no |
| namespace | Namespace to create the ingress in. | `string` | `"ingress-nginx"` | no |
| replica\_count | Number of replicas of the ingress controller to create. Should be 2 or more in production. | `number` | `2` | no |
| use\_network\_load\_balancer | Use an AWS NLB to load balance traffic to the cluster. If false, will create a Classic Load Balancer. NLB is not recommended at this time due to some connection issues. | `bool` | `false` | no |
| use\_proxy\_protocol | If true, will enable proxy protocol support between the Load Balancer and the nginx ingress controller. This allows nginx to know the IP of the client when using an ELB. | `bool` | `true` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
