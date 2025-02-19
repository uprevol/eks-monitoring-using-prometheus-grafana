provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  load_config_file       = false
  token  =data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}


resource "helm_release" "prometheus" {
  depends_on = [module.eks_managed_node_group]
  create_namespace = true
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
 // version    = "15.2.1" # Ensure this matches the version you want
  values = [
    file("helm_values/values_prom.yaml") # Path to your custom values file
  ]
}

resource "helm_release" "grafana" {
  depends_on = [module.eks_managed_node_group]
  create_namespace = true
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
 // version    = "15.2.1" # Ensure this matches the version you want
  set {
    name  = "adminPassword"
    value = "admin"
  }
}





