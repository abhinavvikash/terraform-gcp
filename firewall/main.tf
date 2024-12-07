
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

resource "google_compute_firewall" "gke-node-egress" {
    name    = "allow-node-egress"
    network = var.vpc_name
    allow {
        protocol = "TCP"
        ports    = ["0-65535"]
    }
    allow {
        protocol = "UDP"
        ports    = ["0-65535"]
    }
    allow {
        protocol = "ICMP"
    }
    direction     = "EGRESS"
    priority      = 65534
    destination_ranges = ["0.0.0.0/0"]
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
    ports    = ["22","10006","9999","9092"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}



resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["80","3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}


# resource "google_compute_firewall" "allow-sql-traffic" {
#   name    = "allow-sql-traffic"
#   network = var.vpc_name

#   allow {
#     protocol = "tcp"
#     ports    = ["5432"]
#   }

#   source_ranges = ["10.10.0.0/24"]
# }

# resource "google_compute_firewall" "allow_http" {
#   name    = "allow-http"
#   network = var.vpc_name

#   allow {
#     protocol = "tcp"
#     ports    = ["80","3000"]
#   }

#   source_ranges = ["0.0.0.0/0"]
#   direction     = "EGRESS"
# }
resource "google_compute_firewall" "allow_k8s_to_sql" {
  name    = "allow-k8s-to-sql"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["5432","3307"]
  }

  source_ranges = ["192.2.0.0/16"]
  destination_ranges = ["10.246.0.3"]
}

resource "google_compute_firewall" "allow_gke_egress" {
  name    = "allow-gke-egress"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["10.246.0.3"]
  destination_ranges = ["192.2.0.0/16"]
}


