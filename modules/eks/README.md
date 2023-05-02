# eks

Create a Kubernetes cluster using EKS.

## Notes

This module supports using EKS "Addons" to maintain and upgrade core resources in the cluster like the VPC CNI, kube-proxy and Core DNS.

See the necessary versions for each EKS version here:

[https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html](https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html)

[https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html](https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html)

[https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html](https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html)

*Node group configuration schema:*
```
{
    <group name>: {
        instance_types     = list(string) - List of instance types to use for nodes in the node group. In order of preference. Instance types in a group should be similar in resources.
        asg_min_size       = string (default: "1") - Smallest size of this node group in instances.
        asg_max_size       = string (default: "3") - Largest size of this node group in instances.
        use_spot_instances = bool (default: false) - If true, use spot instances to save cost.
        ami_type           = string (default: "AL2_x86_64") - The type of AMI to use. Other possibilities are AL2_x86_64_GPU for gpu instances or AL2_ARM_64 for ARM instances
        use_large_ip_range = bool (default: true) - If true, enable the "prefix delegation" feature of EKS. This will create a custom launch template for each node group.
        node_ip_limit      = int  (default: 110)  - If using prefix delegation, the max that can be used per node. 110 is the limit for all but the largest instance types.
    },
    ...
}
```
Note: To fully enable prefix delegation, the ENABLE_PREFIX_DELEGATION environment variable must be set to "true" in the aws-node daemonset. Zero will do this automatically when the kubernetes terraform is applied.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.37.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.37.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| addon\_coredns\_version | Version of CoreDNS to install. If empty you will need to upgrade CoreDNS yourself during a cluster version upgrade | `string` | `""` | no |
| addon\_kube\_proxy\_version | Version of kube proxy to install. If empty you will need to upgrade kube proxy yourself during a cluster version upgrade | `string` | `""` | no |
| addon\_vpc\_cni\_version | Version of the VPC CNI to install. If empty you will need to upgrade the CNI yourself during a cluster version upgrade | `string` | `""` | no |
| cluster\_enabled\_log\_types | A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | `[]` | no |
| cluster\_name | Name to be given to the EKS cluster | `any` | n/a | yes |
| cluster\_version | EKS cluster version number to use. Incrementing this will start a cluster upgrade | `any` | n/a | yes |
| eks\_node\_groups | Map of maps of EKS node group config where keys are node group names. See the readme for details. | `any` | n/a | yes |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| force\_old\_cluster\_iam\_role\_name | Compatibility fix - If your cluster was created using a version of this module earlier than 0.4.3, this should be set to true. If the wrong value is set, you may see kubernetes connection issues when running terraform | `bool` | `false` | no |
| iam\_account\_id | Account ID of the current IAM user | `any` | n/a | yes |
| node\_group\_name\_as\_prefix | Use Node Group name as a prefix ? This allow to change instance types. | `bool` | `false` | no |
| private\_subnets | VPC subnets for the EKS cluster | `list(string)` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |
| vpc\_id | VPC ID for EKS cluster | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | Identifier of the EKS cluster |
| worker\_iam\_role\_arn | The ARN of the EKS worker IAM role |
| worker\_iam\_role\_name | The name of the EKS worker IAM role |
| worker\_security\_group\_id | The security group of the EKS workers |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
