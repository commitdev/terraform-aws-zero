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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | The environment (stage/prod) | `any` | n/a | yes |
| project | Name of the project | `any` | n/a | yes |
| roles | Roles to create with associated aws policies | <pre>list(object({<br>    name       = string<br>    aws_policy = string<br>  }))</pre> | n/a | yes |
| users | Users to create with associated roles, mapping to the ones defined in the roles variable | <pre>list(object({<br>    name  = string<br>    roles = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
