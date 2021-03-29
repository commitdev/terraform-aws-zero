# ecr

Create an ECR repository for docker images.

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
| ecr\_principals | List of principals (most likely users) to give full access to the created ECR repositories | `list(string)` | n/a | yes |
| ecr\_repositories | List of ECR repository names to create | `set(string)` | n/a | yes |
| environment | The environment (stage/prod) | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
