resource "google_project_service" "services" {
  project            = var.project_id
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "sql-component" {
  project            = var.project_id
  service            = "sql-component.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "servicenetworking" {
  project            = var.project_id
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [google_project_service.services, google_project_service.sql-component, google_project_service.servicenetworking]

  create_duration = "100s"
}

resource "google_compute_global_address" "private_ip_address" {
#   provider = google-beta
  name     = "google-managed-services-${var.project_id}"
  purpose  = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = var.vpc_name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network = var.vpc_name
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}



resource "google_sql_database_instance" "primary" {
  name                = var.gcp_pg_name_primary
  database_version    = var.gcp_pg_database_version
  region              = var.region
  deletion_protection = false

  settings {
    tier      = var.gcp_pg_tier
    disk_size = 10
    disk_type = "PD_SSD"
    ip_configuration {
      ipv4_enabled = false
      private_network = data.google_compute_network.vpc.id
    }
  }

  depends_on = [google_project_service.services, 
                time_sleep.wait_30_seconds,
                google_service_networking_connection.private_vpc_connection]

}

resource "google_sql_user" "users" {
  name     = var.username
  instance = google_sql_database_instance.primary.name
  password = var.password
}

output "instance_primary_ip_address" {
  value = google_sql_database_instance.primary.ip_address
}