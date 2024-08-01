# GKE cluster
# data "google_container_engine_versions" "gke_version" {
#   location = var.region
#   version_prefix = "1.29."
# }

data "google_client_config" "current" {}

resource "google_container_cluster" "primary" {
  name     = "${var.project_id}-gke"
  location = var.region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = false
  network    = var.vpc_name
  subnetwork = var.subnet_name
  # node_config {
  #   tags = ["k8s-api"]
  # }
  workload_identity_config {
      workload_pool = "${data.google_client_config.current.project}.svc.id.goog"
    }
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  # master_authorized_networks_config {
  #   # enabled = true
  #   cidr_blocks {
  #   cidr_block = var.master_authorized_networks_ips
  #   display_name = "Allow all IPs"
  # }
  # }

}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}nodepool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  
  # version = data.google_container_engine_versions.gke_version.release_channel_latest_version["STABLE"]
  node_count = var.gke_num_nodes
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = var.machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}


provider "kubernetes" {
  load_config_file = "false"

  host = google_container_cluster.primary.endpoint
#   username = var.gke_username
#   password = var.gke_password

  client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}