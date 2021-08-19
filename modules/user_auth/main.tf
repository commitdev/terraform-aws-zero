locals {
  # Kubernetes manifest to configure a custom resource that tells external-secrets where to pull secret data from
  external_secret_definition = {
    apiVersion : "kubernetes-client.io/v1"
    kind : "ExternalSecret"

    metadata : {
      name : var.kratos_secret_name
      namespace : var.auth_namespace
    }
    spec : {
      backendType : var.external_secret_backend
      dataFrom : [var.external_secret_name]
    }
  }

  default_flow_return_url = "https://${var.frontend_service_domain}${var.kratos_default_redirect_ui_path}"
  kratos_values_override = {
    secret = {
      nameOverride = var.kratos_secret_name
    }
    kratos = {
      config = {
        serve = {
          public = {
            base_url = "https://${var.backend_service_domain}/.ory/kratos/public"
          }
          admin = {
            base_url = "https://${var.backend_service_domain}/.ory/kratos/"
          }
        }

        selfservice = {
          whitelisted_return_urls    = var.whitelisted_return_urls
          default_browser_return_url = "https://${var.frontend_service_domain}/"
          flows = {
            settings = {
              ui_url = "https://${var.frontend_service_domain}/auth/settings"
              after = {
                default_browser_return_url = local.default_flow_return_url
              }
            }

            verification = {
              ui_url = "https://${var.frontend_service_domain}/auth/verify"
              after = {
                default_browser_return_url = local.default_flow_return_url
              }
            }

            recovery = {
              ui_url = "https://${var.frontend_service_domain}/auth/recovery"
              after = {
                default_browser_return_url = local.default_flow_return_url
              }
            }

            login = {
              ui_url = "https://${var.frontend_service_domain}/auth/login"
              after = {
                default_browser_return_url = local.default_flow_return_url
              }
            }

            registration = {
              ui_url = "https://${var.frontend_service_domain}/auth/registration"
              after = {
                default_browser_return_url = local.default_flow_return_url
                password = {
                  default_browser_return_url = local.default_flow_return_url
                }
                oidc = {
                  default_browser_return_url = local.default_flow_return_url
                }
              }
            }

            error = {
              ui_url = "https://${var.frontend_service_domain}/auth/errors"
            }

          }
        }
        courier = {
          smtp = {
            from_address = var.user_auth_mail_from_address
          }
        }
      }
    }
  }

  oathkeeper_values_override = {
    ingress = {
      # https://github.com/ory/k8s/blob/master/helm/charts/oathkeeper/templates/ingress-proxy.yaml
      proxy = {
        hosts = [{
          host = var.backend_service_domain
          paths = ["/"]
        }]

        tls = [{
          hosts = [var.backend_service_domain]
          secretName = "oathkeeper-proxy-tls-secret"
        }]

        annotations = {
          "nginx.ingress.kubernetes.io/cors-allow-origin" : "https://${var.frontend_service_domain}"
        }
      }
    }
    oathkeeper = {
      config = {
        authenticators = {
          cookie_session = {
            config = {
              check_session_url = "http://kratos-${var.name}-public/sessions/whoami"
            }
          }
        }

        mutators = {
          id_token = {
            config = {
              issuer_url = "https://${var.backend_service_domain}"
            }
          }
        }

        errors = {
          handlers = {
            redirect = {
              config = {
                to = "https://${var.frontend_service_domain}/auth/login"
              }
            }
          }
        }
      }
    }
  }

}

resource "kubernetes_namespace" "user_auth" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.auth_namespace
  }
}

# Use local exec here because we are creating a custom resource which is not yet supported by the terraform kubernetes provider
resource "null_resource" "external_secret_custom_resource" {
  count = var.external_secret_backend == "" ? 0 : 1

  triggers = {
    manifest_sha1 = sha1(jsonencode(local.external_secret_definition))
  }

  provisioner "local-exec" {
    command = "kubectl apply ${var.kubectl_extra_args} -n ${var.auth_namespace} -f - <<EOF\n${jsonencode(local.external_secret_definition)}\nEOF"
  }

  depends_on = [kubernetes_namespace.user_auth]
}

module "kratos_config" {
  source  = "cloudposse/config/yaml"
  version = "0.7.0"

  map_config_local_base_path = "${path.module}/files"
  map_config_paths           = ["kratos-values.yml"]
  map_configs                = [local.kratos_values_override, var.kratos_values_override]
}

resource "helm_release" "kratos" {

  name       = "kratos-${var.name}"
  repository = "https://k8s.ory.sh/helm/charts"
  chart      = "kratos"
  version    = "0.4.11"
  namespace  = var.auth_namespace
  depends_on = [kubernetes_namespace.user_auth]

  values = [
    jsonencode(module.kratos_config.map_configs)
  ]
  set_sensitive {
    name  = "kratos.config.secrets.default[0]"
    value = var.cookie_signing_secret_key
  }

  # set {
  #   name = "kratos.config.dsn"
  #   # SQLite can be used for testing but there is no persistent storage set up for it
  #   value = "sqlite:///var/lib/sqlite/db.sqlite?_fk=true&mode=rwc"
  #   # value = "${local.db_type}://${kubernetes_service.app_db.metadata[0].name}.${kubernetes_service.app_db.metadata[0].namespace}"
  # }
}

data "template_file" "oathkeeper_kratos_proxy_rules" {
  template = file("${path.module}/files/oathkeeper_kratos_proxy_rules.yaml.tpl")
  vars = {
    name                      = var.name
    backend_service_domain    = var.backend_service_domain
    public_selfserve_endpoint = "/.ory/kratos/public"
    admin_selfserve_endpoint  = "/.ory/kratos"
  }
}

resource "null_resource" "oathkeeper_kratos_proxy_rules" {
  triggers = {
    manifest_sha1 = sha1(data.template_file.oathkeeper_kratos_proxy_rules.rendered)
  }
  # local exec call requires kubeconfig to be updated
  provisioner "local-exec" {
    command = "kubectl apply ${var.k8s_local_exec_context} -f - <<EOF\n${data.template_file.oathkeeper_kratos_proxy_rules.rendered}\nEOF"
  }
  depends_on = [helm_release.oathkeeper]
}

module "oathkeeper_config" {
  source  = "cloudposse/config/yaml"
  version = "0.7.0"

  map_config_local_base_path = "${path.module}/files"
  map_config_paths           = ["oathkeeper-values.yml"]
  map_configs                = [local.oathkeeper_values_override, var.oathkeeper_values_override]
}

resource "helm_release" "oathkeeper" {

  name       = "oathkeeper-${var.name}"
  repository = "https://k8s.ory.sh/helm/charts"
  chart      = "oathkeeper"
  version    = "0.4.11"
  namespace  = var.auth_namespace
  depends_on = [kubernetes_namespace.user_auth]

  values = [
    jsonencode(module.oathkeeper_config.map_configs)
  ]

  # Clean up and set the JWKS content. This will become a secret mounted into the pod
  set_sensitive {
    name  = "oathkeeper.mutatorIdTokenJWKs"
    value = replace(jsonencode(jsondecode(var.jwks_content)), "/([,\\[\\]{}])/", "\\$1")
  }
}
