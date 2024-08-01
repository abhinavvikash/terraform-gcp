provider "google" {
  project = "playpen-742d6a"
  region  = "europe-west1"
  
}

terraform {
  backend "remote" {
    organization = "lbg-cloud-platform"

    workspaces {
      name = "playpen-742d6a-gcp"
    }
    
  }
}

resource "google_storage_bucket" "dp-bucket" {
  project                     = var.project_id
  name                        = var.bucket_name
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