terraform {
  backend "gcs" {
  bucket = "playpen-48aa0c-terraform-bucket"
  prefix = "terraform/state/artifact_registry"
  
}
}