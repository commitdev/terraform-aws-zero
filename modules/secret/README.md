# secret

Create a secret using AWS Secret Manager.

## Notes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The name of the secret in Secrets Manager (only one of name or name\_prefix can be specified) | `string` | `""` | no |
| random\_length | The length of the generated string if type is random. Suitable for a db master password for example | `number` | `16` | no |
| tags | Tags to include in the secret | `map` | `{}` | no |
| type | The type of data to hold in this secret (map, string, random) | `any` | n/a | yes |
| value | A string value to save for the secret if type is string | `string` | `""` | no |
| values | A map of keys/values to save as json for the secret if type is map | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| secret\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
