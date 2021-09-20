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
| helm | n/a |
| kubernetes | n/a |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auth\_namespace | Namespace to use for auth resources | `string` | `"user-auth"` | no |
| backend\_service\_domain | Domain of the backend service | `string` | n/a | yes |
| cookie\_signing\_secret\_key | Default secret key for signing cookies | `string` | n/a | yes |
| create\_namespace | Whether to create the auth namespace(defaults to true), otherwise just references the namespace | `bool` | `true` | no |
| disable\_oathkeeper | To not provision Oathkeeper, this is useful when you want multiple Kratos setup, while only 1 Oathkeeper proxy to route to them, for example sharing Oathkeeper between a Dev and Staging Kratos | `bool` | `false` | no |
| external\_secret\_backend | The backend external-secrets will pull secret data from to create a corresponding secret in kubernetes. If empty, external-secrets will not be used. You'll need to make sure the secret is created manually. | `string` | `"secretsManager"` | no |
| external\_secret\_name | Name of a secret in an external secrets backend that contains the content to pull into a kubernetes secret for Kratos to use | `string` | n/a | yes |
| frontend\_service\_domain | Domain of the frontend | `string` | n/a | yes |
| frontend\_use\_https | Whether frontend URLs should be https, unless your developing locally you should leave the default as is. | `bool` | `true` | no |
| jwks\_content | The content of a JWKS file for Oathkeeper | `string` | n/a | yes |
| k8s\_local\_exec\_context | Custom resource (Oathkeeper Rules are created using local-exec with kubectl), if not specified it will target your current context from kubeconfig | `string` | `""` | no |
| kratos\_default\_redirect\_ui\_path | Setting the default path after self-service flows(login/signup/verify/settings), kratos will redirect you to frontend | `string` | `"/dashboard"` | no |
| kratos\_image\_tag | Kratos image to use with user-auth, you can specify the docker hub image from repository: oryd/kratos | `string` | `"v0.5.4-alpha.1-sqlite"` | no |
| kratos\_secret\_name | Secret name for kratos to access Database credentials, created from pre-k8s script | `string` | n/a | yes |
| kratos\_values\_override | a map of parameters to override the kratos-values.yml | `map(any)` | `{}` | no |
| kubectl\_extra\_args | Arguments that will be passed to kubectl when using the local executor in cases where the terraform k8s support is not enough | `string` | n/a | yes |
| name | The name to create user-auth components(kratos/oathkeeper), must be unique in the cluster for helm-resources | `string` | n/a | yes |
| oathkeeper\_image\_tag | Oathkeeper image to use with user-auth, you can specify the docker hub image from repository: oryd/oathkeeper | `string` | `"v0.38.4-beta.1"` | no |
| oathkeeper\_values\_override | a map of parameters to override the oathkeeper-values.yml | `map(any)` | `{}` | no |
| user\_auth\_mail\_from\_address | Mail from the user management system will come from this address | `string` | `""` | no |
| whitelisted\_return\_urls | URLs that can be redirected to after completing a flow initialized with the return\_to parameter | `list(string)` | `[]` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
