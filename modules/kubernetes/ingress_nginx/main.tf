locals {
  log_format = <<EOF
{
 "timestamp": "$time_iso8601",
 "remote_addr": "$remote_addr",
 "remote_user": "$remote_user",
 "request": "$request",
 "status": "$status",
 "request_id": "$req_id",
 "bytes_sent": "$bytes_sent",
 "request_method": "$request_method",
 "request_length": "$request_length",
 "request_time": "$request_time",
 "http_referrer": "$http_referer",
 "http_user_agent": "$http_user_agent",
 "host": "$host",
 "request_proto": "$server_protocol",
 "path": "$uri",
 "request_query": "$args",
 "http_x_forwarded_for": "$proxy_add_x_forwarded_for"
}
EOF

  configmap_defaults = {
    "proxy-real-ip-cidr"         = "0.0.0.0/0"
    "use-forwarded-headers"      = "true"
    "use-proxy-protocol"         = "false"
    "log-format-escape-json"     = "true"
    "log-format-upstream"        = replace(local.log_format, "\n", "")
    "generate-request-id"        = "true"
    "upstream-keepalive-timeout" = var.connection_idle_timeout + 5
  }

  helm_values = {
    controller : {
      config : merge(local.configmap_defaults, var.additional_configmap_options)
      replicaCount : var.replica_count
      metrics : {
        enabled : var.enable_metrics
        serviceMonitor : {
          enabled : var.enable_metrics
          namespace : "metrics"
        }
      }
      service : {
        annotations : {
          "service.beta.kubernetes.io/aws-load-balancer-backend-protocol" : "tcp"
          "service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout" : var.connection_idle_timeout
          "service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled" : true
          "service.beta.kubernetes.io/aws-load-balancer-type" : var.use_network_load_balancer ? "nlb" : "elb"
        }
      }

    }
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = var.namespace
    labels = {
      "app.kubernetes.io/name"    = "ingress-nginx",
      "app.kubernetes.io/part-of" = "ingress-nginx"
    }
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.chart_version
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  values     = [jsonencode(local.helm_values)]
}

