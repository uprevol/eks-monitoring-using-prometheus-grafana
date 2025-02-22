resource "helm_release" "prometheus" {
  depends_on = [helm_release.aws_load_balancer_controller] // Added this code to ensure loadbalancer controller is available 
  create_namespace = true
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
 // version    = "15.2.1" # Ensure this matches the version you want
  values = [templatefile("helm_values/values_prom.yaml", {
    DESTINATION_GMAIL_ID   = var.DESTINATION_GMAIL_ID
    SOURCE_AUTH_PASSWORD   = var.SOURCE_AUTH_PASSWORD
    SOURCE_GMAIL_ID        = var.SOURCE_GMAIL_ID
  })]
}

resource "helm_release" "grafana" {
  depends_on = [module.eks_managed_node_group]
  create_namespace = true
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
 // version    = "15.2.1" # Ensure this matches the version you want
  values = [
    file("helm_values/values_grafana.yaml") # Path to your custom values file
  ]
  set {
    name  = "adminPassword"
    value = "admin"
  }
}



