# user_access

Create IAM Roles/Groups and Kubernetes Cluster Roles for user access

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assumerole\_account\_ids | AWS account IDs that will be allowed to assume the roles we are creating. If left blank, the AWS account you are using will be used | `list(string)` | `[]` | no |
| environment | The environment (stage/prod) | `any` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |
| roles | Roles to create with associated aws and k8s policies | <pre>list(object({<br>    name         = string<br>    aws_policy   = string<br>    k8s_policies = list(map(list(string)))<br>  }))</pre> | n/a | yes |
| users | Users to create with associated roles, mapping to the ones defined in the roles variable | <pre>list(object({<br>    name  = string<br>    roles = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| eks\_iam\_role\_mapping | List of mappings of users to roles |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
