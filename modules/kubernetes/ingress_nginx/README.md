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
| chart\_version | The version of helm chart to use. | `string` | `"3.25.0"` | no |
| connection\_idle\_timeout | The amount of time the load balancer will keep an idle connection open for. The value of nginx upstream-keepalive-timeout will also be set to this value + 5. If it were shorter than the LB timeout it could cause intermittent 502s. | `number` | `55` | no |
| enable\_metrics | Enable prometheus metrics support, including adding a ServiceMonitor. | `bool` | n/a | yes |
| namespace | Namespace to create the ingress in. | `string` | `"ingress-nginx"` | no |
| replica\_count | Number of replicas of the ingress controller to create. Should be 2 or more in production. | `number` | `2` | no |
| use\_network\_load\_balancer | Use an AWS NLB to load balance traffic to the cluster. Recommended. If false, will create a Classic Load Balancer. | `bool` | `true` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
