# user_auth

User management and Identity / Access Proxy using Ory Kratos and Oathkeeper 

## Notes
This module uses helm-charts to create a user authentication suite (Kratos, Oathkeeper, Oathkeeper-measter) in your Kubernetes cluster through your Kubernetes Provider, to provide user identity and authentication.

## Pre-requisites
### jwks_secret_name
This is a Private key stored in secret-manager used to sign tokens for user sessions, it is created in the Zero apply step during [`pre-k8s.sh`](https://github.com/commitdev/zero-aws-eks-stack/blob/main/templates/scripts/pre-k8s.sh#L22-L32)

### auth database / secret 
This is a database and connection-credentials created for Kratos, it is created in the Zero apply step during [`pre-k8s.sh`](https://github.com/commitdev/zero-aws-eks-stack/blob/main/templates/scripts/pre-k8s.sh#L22-L32)


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | n/a |
| kubernetes | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auth\_namespace | Namespace to use for auth resources | `string` | `"user-auth"` | no |
| aws\_secrets\_manager\_secret\_name | Name of a secret in AWS Secrets Manager that contains the content to pull into a kubernetes secret for Kratos to use | `string` | n/a | yes |
| backend\_service\_domain | Domain of the backend service | `string` | n/a | yes |
| cookie\_signing\_secret\_key | Default secret key for signing cookies | `string` | n/a | yes |
| create\_namespace | Whether to create the auth namespace(defaults to true), otherwise just references the namespace | `bool` | `true` | no |
| frontend\_service\_domain | Domain of the frontend | `string` | n/a | yes |
| jwks\_secret\_name | The name of a secret in the auth namespace containing a JWKS file for Oathkeeper | `string` | n/a | yes |
| k8s\_local\_exec\_context | Custom resource (Oathkeeper Rules are created using local-exec with kubectl), if not specified it will target your current context from kubeconfig | `string` | `""` | no |
| kratos\_secret\_name | Secret name for kratos to access Database credentials, created from pre-k8s script | `string` | n/a | yes |
| kubectl\_extra\_args | Arguments that will be passed to kubectl when using the local executor in cases where the terraform k8s support is not enough | `string` | n/a | yes |
| name | The name to create user-auth components(kratos/oathkeeper), must be unique in the cluster for helm-resources | `string` | n/a | yes |
| user\_auth\_mail\_from\_address | Mail from the user management system will come from this address | `string` | `""` | no |
| whitelisted\_return\_urls | URLs that can be redirected to after completing a flow initialized with the return\_to parameter | `list(string)` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
