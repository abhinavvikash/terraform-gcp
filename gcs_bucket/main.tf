
resource "google_storage_bucket" "dp-bucket" {
  project                     = var.project_id
  name                        = var.dataproc_bucket_name
  uniform_bucket_level_access = true
  location                    = var.region
  force_destroy               = true
}

resource "google_storage_bucket" "terraform_bucket" {
  project = var.project_id
  name = var.terraform_bucket_name
  location = var.region
  force_destroy = true

}

resource "google_storage_bucket" "jar_bucket" {
  project = var.project_id
  name = var.jar_bucket_name
  location = var.region
  force_destroy = true
}