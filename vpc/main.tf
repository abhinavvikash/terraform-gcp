provider "google" {
  project = "playpen-48aa0c"
  region  = "europe-west1"
  
}

terraform {
  backend "gcs" {
  bucket = "playpen-48aa0c-terraform-bucket"
  prefix = "terraform/state/vpc"
  }
}

resource "google_compute_network" "vpc" {
  name                   = var.vpc_name
  auto_create_subnetworks = "false"
}

# dataproc Subnet
resource "google_compute_subnetwork" "subnet_dataproc" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

# gke subnet
resource "google_compute_subnetwork" "subnet_gke" {
  name          = var.gke_subnet_name
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "192.1.0.0/16"
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "192.2.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "192.3.0.0/16"
  }
}


