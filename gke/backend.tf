terraform {
  backend "gcs" {
  bucket = "playpen-742d6a-terraform-bucket"
  prefix = "terraform/state/gke"
  
}
}