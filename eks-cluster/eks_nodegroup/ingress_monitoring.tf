/*
provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  load_config_file       = false
  token  =data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

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
        "alb.ingress.kubernetes.io/load-balancer-name" = "poc-alb"
        "alb.ingress.kubernetes.io/certificate-arn" = "${aws_acm_certificate.cert.arn}"
        "alb.ingress.kubernetes.io/group.name": "myapp"

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
        "alb.ingress.kubernetes.io/group.name": "myapp"
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
*/