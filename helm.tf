provider "helm" {
  kubernetes {
    config_path = "~/.k3d/kubeconfig-demo.yaml"
  }
}

# resource "helm_release" "elk" {
#   name             = "elk-release"
#   namespace        = "elastic-system"
#   create_namespace = "true"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "elasticsearch"
#   version          = "19.5.10"
#   set {
#     name  = "global.kibanaEnabled"
#     value = "true"
#   }
# }

resource "helm_release" "monitoring" {
  name             = "monitoring-release"
  namespace        = "monitoring-system"
  create_namespace = "true"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "45.0.0"
}
