provider "k3d" {
  # Configuration options
}

resource "k3d_cluster" "mycluster" {
  name    = "demo"
  servers = 1
  agents  = 2
}

