resource "google_spanner_instance" "example" {
  config       = var.config_name
  display_name = "Foundation Spanner Instance"
  processing_units    = var.processing_units
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.example.name
  name     = "foundation-db"
  version_retention_period = "3d"
  ddl = [
    "CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)",
    "CREATE TABLE t2 (t2 INT64 NOT NULL,) PRIMARY KEY(t2)",
  ]
  deletion_protection = false
}