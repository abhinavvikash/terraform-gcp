terraform {
  backend "gcs" {
  bucket = "playpen-795065-terraform-bucket"
  prefix = "terraform/state/big_query"
  
}
}
