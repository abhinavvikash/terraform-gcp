provider "google" {
  project = "playpen-48aa0c"
  region  = "europe-west1"
  
}

terraform {
  backend "gcs" {
  bucket = "playpen-48aa0c-terraform-bucket"
  prefix = "terraform/state/firewall"
  }
}

resource "google_compute_firewall" "dp-firewall" {
    name = "dataproc-allow-firewall"
    network = var.vpc_name
    allow{
        protocol = "TCP"
        ports = ["0-65535"]
    }
    allow{
        protocol = "UDP"
        ports = ["0-65535"]
    }
    allow{
        protocol = "ICMP"
    }
    direction = "INGRESS"
    priority  = 65534
    source_ranges = var.source_ranges
}

# resource "google_compute_firewall" "allow_k8s_api" {
#   name    = "allow-k8s-api"
#   network = var.vpc_name

#   allow {
#     protocol = "tcp"
#     ports    = ["443"]
#   }
#   source_ranges = ["20.162.162.62/32"]
# }

resource "google_compute_firewall" "gke-node-firewall" {
    name = "allow-node-communication"
    network = var.vpc_name
    allow{
        protocol = "TCP"
        ports = ["0-65535"]
    }
    allow{
        protocol = "UDP"
        ports = ["0-65535"]
    }
    allow{
        protocol = "ICMP"
    }
    direction = "INGRESS"
    priority  = 65534
    source_ranges =  ["192.1.0.0/16"]
}