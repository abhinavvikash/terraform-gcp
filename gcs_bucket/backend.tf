terraform {
  backend "remote" {
    organization = "lbg-cloud-platform"

    workspaces {
      name = "playpen-795065-gcp"
    }
    
  }
}