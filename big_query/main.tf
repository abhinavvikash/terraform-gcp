resource "google_bigquery_dataset" "default" {
  dataset_id = "foundation_dataset"
  friendly_name = "Foundation Dataset"
  description = "This is a Foundation dataset"
  location = var.location
  labels = {
    env = "dev"
  }
}