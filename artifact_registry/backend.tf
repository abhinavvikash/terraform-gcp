terraform {
  backend "gcs" {
  bucket = "playpen-2f4e18-terraform-bucket"
  prefix = "terraform/state/artifact_registry"  
}
}