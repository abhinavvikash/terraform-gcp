
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

resource "google_compute_firewall" "allow_gcr" {
  name    = "allow-gcr"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  destination_ranges = ["199.36.153.4/30"]
  direction          = "EGRESS"
  description        = "Allow GKE nodes to pull images from eu.gcr.io"
}


resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}



resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}


resource "google_compute_firewall" "allow-sql-traffic" {
  name    = "allow-sql-traffic"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["10.10.0.0/24"]
}
