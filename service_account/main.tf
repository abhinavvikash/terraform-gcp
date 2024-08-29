
terraform {
  backend "gcs" {
  bucket = "playpen-48aa0c-terraform-bucket"
  prefix = "terraform/state/service_account"
  
}
}


resource "google_service_account" "dataproc-svc" {
  project      = var.project_id
  account_id   = "dataproc-svc"
  display_name = "Service Account - dataproc"
}

resource "google_project_iam_member" "dataproc_permissions" {
  for_each = toset([
    "roles/dataproc.editor",
    "roles/iam.serviceAccountUser",
    "roles/storage.objectAdmin",
    "roles/dataproc.worker",

  ])
  project = var.project_id
  role = each.key
  member = "serviceAccount:${google_service_account.dataproc-svc.email}"
}

#artifact registry service account
resource "google_service_account" "artifact-svc" {
  project      = var.project_id
  account_id   = "artifact-svc"
  display_name = "Service Account - artifact registry"
}

resource "google_project_iam_member" "registry_permissions" {
  for_each = toset([
    "roles/artifactregistry.admin",

  ])
  project = var.project_id
  role = each.key
  member = "serviceAccount:${google_service_account.artifact-svc.email}"
}





# kubernetes service account

# resource "kubernetes_service_account" "ksa" {
#   metadata {
#     name      = "dataproc-ksa"
#     namespace = "default"
#     annotations = {
#       "iam.gke.io/gcp-service-account" = "${google_service_account.dataproc-svc.email}"
#     }
#   }
# }

#binding of KSA to GSA

# resource "google_service_account_iam_binding" "binding" {
#   service_account_id = google_service_account.dataproc-svc.name

#   role = "roles/iam.workloadIdentityUser"

#   members = [
#     "serviceAccount:${var.project_id}.svc.id.goog[default/dataproc-ksa]",
#     "serviceAccount:${var.project_id}.svc.id.goog[default/agent]",
#     "serviceAccount:${var.project_id}.svc.id.goog[default/spark-driver]",
#     "serviceAccount:${var.project_id}.svc.id.goog[default/spark-executor]",
#   ]
# }

#Annotate the KSA with the GSA

# resource "kubernetes_service_account" "ksa" {
#   metadata {
#     name      = "dataproc-ksa"
#     namespace = "default"
#     annotations = {
#       "iam.gke.io/gcp-service-account" = "${google_service_account.dataproc-svc.email}"
#     }
#   }
# }

