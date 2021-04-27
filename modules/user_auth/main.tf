## Get generated JWKS content from secret
data "aws_secretsmanager_secret" "jwks_content" {
  name = var.jwks_secret_name
}
data "aws_secretsmanager_secret_version" "jwks_content" {

  secret_id = data.aws_secretsmanager_secret.jwks_content.id
}

resource "kubernetes_namespace" "user_auth" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.auth_namespace
  }
}

resource "helm_release" "kratos" {

  name       = "kratos-${var.name}"
  repository = "https://k8s.ory.sh/helm/charts"
  chart      = "kratos"
  version    = "0.4.11"
  namespace  = var.auth_namespace

  values = [
    file("${path.module}/files/kratos-values.yml"),
  ]

  # This secret contains db credentials created during the initial zero apply command
  set {
    name  = "secret.nameOverride"
    value = var.kratos_secret_name
  }

  # set {
  #   name = "kratos.config.dsn"
  #   # SQLite can be used for testing but there is no persistent storage set up for it
  #   value = "sqlite:///var/lib/sqlite/db.sqlite?_fk=true&mode=rwc"
  #   # value = "${local.db_type}://${kubernetes_service.app_db.metadata[0].name}.${kubernetes_service.app_db.metadata[0].namespace}"
  # }

  set {
    name  = "kratos.config.courier.smtp.from_address"
    value = var.user_auth_mail_from_address
  }

  set_sensitive {
    name  = "kratos.config.secrets.default[0]"
    value = var.cookie_sigining_secret_key
  }

  set {
    name  = "kratos.config.serve.public.base_url"
    value = "https://${var.backend_service_domain}/.ory/kratos/public"
  }

  set {
    name  = "kratos.config.serve.admin.base_url"
    value = "https://${var.backend_service_domain}/.ory/kratos/"
  }

  # Return urls
  set {
    name  = "kratos.config.selfservice.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/"
  }

  dynamic "set" {
    for_each = var.whitelisted_return_urls
    iterator = whitelist_url
    content {
      name  = "kratos.config.selfservice.whitelisted_return_urls[${whitelist_url.key}]"
      value = whitelist_url.value
    }
  }

  set {
    name  = "kratos.config.selfservice.flows.settings.ui_url"
    value = "https://${var.frontend_service_domain}/auth/settings"
  }

  set {
    name  = "kratos.config.selfservice.flows.settings.after.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/dashboard"
  }

  set {
    name  = "kratos.config.selfservice.flows.verification.ui_url"
    value = "https://${var.frontend_service_domain}/auth/verify"
  }

  set {
    name  = "kratos.config.selfservice.flows.verification.after.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/dashboard"
  }

  set {
    name  = "kratos.config.selfservice.flows.recovery.ui_url"
    value = "https://${var.frontend_service_domain}/auth/recovery"
  }

  set {
    name  = "kratos.config.selfservice.flows.logout.after.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/"
  }

  set {
    name  = "kratos.config.selfservice.flows.login.ui_url"
    value = "https://${var.frontend_service_domain}/auth/login"
  }

  set {
    name  = "kratos.config.selfservice.flows.login.after.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/dashboard"
  }

  set {
    name  = "kratos.config.selfservice.flows.registration.ui_url"
    value = "https://${var.frontend_service_domain}/auth/registration"
  }

  set {
    name  = "kratos.config.selfservice.flows.registration.after.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/dashboard"
  }

  set {
    name  = "kratos.config.selfservice.flows.registration.after.password.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/dashboard"
  }

  set {
    name  = "kratos.config.selfservice.flows.registration.after.oidc.default_browser_return_url"
    value = "https://${var.frontend_service_domain}/dashboard"
  }

  set {
    name  = "kratos.config.selfservice.flows.error.ui_url"
    value = "https://${var.frontend_service_domain}/auth/errors"
  }
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

resource "helm_release" "oathkeeper" {

  name       = "oathkeeper-${var.name}"
  repository = "https://k8s.ory.sh/helm/charts"
  chart      = "oathkeeper"
  version    = "0.4.11"
  namespace  = var.auth_namespace

  values = [
    file("${path.module}/files/oathkeeper-values.yml"),
  ]

  set {
    name  = "oathkeeper.config.mutators.id_token.config.issuer_url"
    value = "https://${var.backend_service_domain}"
  }

  set {
    name  = "oathkeeper.config.authenticators.cookie_session.config.check_session_url"
    value = "http://kratos-${var.name}-public/sessions/whoami"
  }

  # Clean up and set the JWKS content. This will become a secret mounted into the pod
  set_sensitive {
    name  = "oathkeeper.mutatorIdTokenJWKs"
    value = replace(jsonencode(jsondecode(data.aws_secretsmanager_secret_version.jwks_content.secret_string)), "/([,\\[\\]{}])/", "\\$1")
  }

  set {
    name  = "oathkeeper.config.errors.handlers.redirect.config.to"
    value = "https://${var.frontend_service_domain}/auth/login"
  }

  set {
    name  = "ingress.proxy.hosts[0].host"
    value = var.backend_service_domain
  }

  set {
    name  = "ingress.proxy.annotations.nginx\\.ingress\\.kubernetes\\.io/cors-allow-origin"
    value = "https://${var.frontend_service_domain}"
  }

  set {
    name  = "ingress.proxy.tls[0].hosts[0]"
    value = var.backend_service_domain
  }
}
