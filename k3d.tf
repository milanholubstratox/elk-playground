provider "k3d" {
  # Configuration options
}

resource "k3d_cluster" "mycluster" {
  name    = "demo"
  servers = 1
  agents  = 2
  volume {
    source      = "/etc/machine-id"
    destination = "/etc/machine-id"
  }
  registries {
    use = ["k3d-docker-io:5001","k3d-elastic-co:5002"]
    config = <<EOF
mirrors:
  "docker.io":
    endpoint:
      - http://k3d-docker-io:5001
  "elastic.co":
    endpoint:
      - http://k3d-elastic-co:5002
EOF
  }
}

