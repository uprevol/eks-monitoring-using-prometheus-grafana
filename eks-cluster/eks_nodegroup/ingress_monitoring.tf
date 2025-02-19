resource "kubectl_manifest" "prometheus_ingress" {
    depends_on = [ helm_release.prometheus]
  yaml_body = jsonencode({
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = "prometheus-ingress"
      namespace = "monitoring"
      annotations = {
        "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
        "alb.ingress.kubernetes.io/target-type"      = "ip"
        "alb.ingress.kubernetes.io/group.name"       = "prometheus-group"
        "alb.ingress.kubernetes.io/healthcheck-path" = "/-/ready"
      }
    }
    spec = {
      ingressClassName = "alb"
      rules = [{
        host = "prometheus.devops4solutions.com"
        http = {
          paths = [{
            path     = "/"
            pathType = "Prefix"
            backend = {
              service = {
                name = "prometheus-server"
                port = {
                  number = 80
                }
              }
            }
          }]
        }
      }]
    }
  })
}

resource "kubectl_manifest" "grafana_ingress" {
        depends_on = [ helm_release.grafana]

  yaml_body = jsonencode({
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = "grafana-ingress"
      namespace = "monitoring"
      annotations = {
        "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
        "alb.ingress.kubernetes.io/target-type"      = "ip"
        "alb.ingress.kubernetes.io/group.name"       = "prometheus-group"
        "alb.ingress.kubernetes.io/healthcheck-path" = "/api/health"
      }
    }
    spec = {
      ingressClassName = "alb"
      rules = [{
        host = "grafana.devops4solutions.com"
        http = {
          paths = [{
            path     = "/"
            pathType = "Prefix"
            backend = {
              service = {
                name = "grafana"
                port = {
                  number = 80
                }
              }
            }
          }]
        }
      }]
    }
  })
}