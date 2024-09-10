terraform {
  backend "gcs" {
  bucket = "playpen-e16de4-terraform-bucket"
  prefix = "terraform/state/virtual_machine"
  }
}