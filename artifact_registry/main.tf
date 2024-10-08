resource "google_artifact_registry_repository" "dm-repo" {
  project = var.project_id
  location      = var.region
  repository_id = var.repository_name  
  description   = "dm docker repository"
  format        = "DOCKER"
  docker_config {
    immutable_tags = true
  }
}