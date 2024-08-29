# resource "google_artifact_registry_vpcsc_config" "my-config" {
#   provider      = google-beta
#   location      = "europe-west1"
#   vpcsc_policy   = "ALLOW"
#   project        = var.project_id
# }
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