provider "helm" {
  kubernetes {
    config_path = "~/.k3d/kubeconfig-demo.yaml"
  }
}

# resource "helm_release" "eck" {
#   name             = "elastic"
#   namespace        = "elastic-system"
#   create_namespace = "true"
#   repository       = "https://helm.elastic.co"
#   chart            = "eck-operator"
#   version          = "2.6.1"
# }

resource "helm_release" "es" {
  name             = "es"
  namespace        = "elastic-system"
  create_namespace = "true"
  repository       = "https://helm.elastic.co"
  chart            = "elasticsearch"
  version          = "8.5.1"
  set {
    name  = "volumeClaimTemplate.resources.requests.storage"
    value = "10Gi" # default 30Gi
  }
  set {
    name  = "replicas"
    value = "1" # default 3
  }
  depends_on = [k3d_cluster.mycluster]
}

resource "helm_release" "kibana" {
  name             = "kibana"
  namespace        = "elastic-system"
  create_namespace = "true"
  repository       = "https://helm.elastic.co"
  chart            = "kibana"
  version          = "8.5.1"
  depends_on = [k3d_cluster.mycluster,helm_release.es]
}

resource "helm_release" "fluent" {
  name             = "fluent"
  namespace        = "logging-system"
  create_namespace = "true"
  repository       = "https://fluent.github.io/helm-charts"
  chart            = "fluent-bit"
  version          = "0.24.0"
  depends_on = [k3d_cluster.mycluster,helm_release.es]
}

resource "helm_release" "monitoring" {
  name             = "monitoring-release"
  namespace        = "monitoring-system"
  create_namespace = "true"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "45.0.0"
  depends_on = [k3d_cluster.mycluster]
}

# resource "helm_release" "elk" {
# name             = "elk-release"
# namespace        = "elastic-system"
# create_namespace = "true"
# repository       = "https://charts.bitnami.com/bitnami"
# chart            = "elasticsearch"
# version          = "19.5.10"
# set {
# name  = "global.kibanaEnabled"
# value = "true"
# }
# }

