# Dataproc service account
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

# Artifact service account
resource "google_service_account" "artifact_registry_sa" {
  account_id   = "artifact-registry-sa"
  display_name = "Artifact Registry Service Account"
}

resource "google_project_iam_binding" "artifact_registry_role" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"

  members = [
    "serviceAccount:${google_service_account.artifact_registry_sa.email}"
  ]
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

# GKE service account

resource "google_service_account" "gke_sa" {
  account_id   = "gke-cluster-access"
  display_name = "GKE Cluster access service account"
}

resource "google_project_iam_binding" "gke_role" {
  for_each = toset([
    "roles/container.clusterAdmin",
    "roles/artifactregistry.reader",
    "roles/cloudsql.admin",
    "roles/storage.objectViewer"
  ])
  project = var.project_id
  role    = each.key

  members = [
    "serviceAccount:${google_service_account.gke_sa.email}"
  ]
}

resource "google_service_account_iam_binding" "workload_identity_binding" {
  # project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.gke_sa.name
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[default/foundation-component-service-account]"
  ]
}

# resource "google_project_iam_binding" "user_impersonation" {
#   project = var.project_id
#   role = "roles/iam.serviceAccountUser"
#   members = [
#     "user:abhinav.vikash@lloydsbanking.dev",
#     "user:madhbhavikar.prasad@lloydsbanking.dev",
#     "user:arvind.ojha1@lloydsbanking.dev",
#     "user:veeresh.hosur@lloydsbanking.dev"
#   ]
# }


#VM service account
resource "google_service_account" "vm_service_account" {
  account_id   = "vm-service-account"
  display_name = "VM Service Account"
}

resource "google_project_iam_member" "vm_service_account_roles" {
  for_each = toset([
    "roles/compute.instanceAdmin.v1",
    "roles/iam.serviceAccountUser",
    "roles/storage.objectViewer",
    "roles/cloudsql.client"
    // Add other roles as needed
  ])
  project = var.project_id
  member  = "serviceAccount:${google_service_account.vm_service_account.email}"
  role    = each.value
}