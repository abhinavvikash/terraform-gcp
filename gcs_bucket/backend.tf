terraform {
  backend "remote" {
    organization = "lbg-cloud-platform"

    workspaces {
      name = "playpen-e16de4-gcp"
    }
    
  }
}