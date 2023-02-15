terraform {
  required_providers {
    k3d = {
      source  = "pvotal-tech/k3d"
      version = "0.0.6"
    }
    helm = {
      source = "hashicorp/helm"
      version = "2.8.0"
    }
  }
}

