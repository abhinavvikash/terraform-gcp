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
  lifecycle {
    ignore_changes = [
      # List the attributes you want to ignore changes for
      role
    ]
  }
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
  lifecycle {
    ignore_changes = [
      # List the attributes you want to ignore changes for
      role
    ]
  }
}

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
  lifecycle {
    ignore_changes = [
      # List the attributes you want to ignore changes for
      role
    ]
  }
}

resource "google_service_account_iam_binding" "workload_identity_binding" {
  # project = var.project_id
  role    = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.gke_sa.name
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[default/foundation-component-service-account]"
  ]
  lifecycle {
  ignore_changes = [
    # List the attributes you want to ignore changes for
    role
  ]
}
}


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
    "roles/cloudsql.client",
    "roles/compute.networkAdmin",
    "roles/dataproc.editor",
    "roles/storage.admin"
    // Add other roles as needed
  ])
  project = var.project_id
  member  = "serviceAccount:${google_service_account.vm_service_account.email}"
  role    = each.value
  lifecycle {
  ignore_changes = [
    # List the attributes you want to ignore changes for
    role
  ]
}
}

resource "google_service_account" "cloud_build" {
  account_id   = "image-build-account"
  display_name = "Gcloud Build"
}

resource "google_project_iam_member" "cloud_build_roles" {
  for_each = toset([
    "roles/storage.objectViewer",
    "roles/logging.logWriter",
    "roles/artifactregistry.writer"
    // Add other roles as needed
  ])
  project = var.project_id
  member  = "serviceAccount:${google_service_account.cloud_build.email}"
  role    = each.value
    lifecycle {
    ignore_changes = [
      # List the attributes you want to ignore changes for
      role
    ]
  }
}

resource "google_service_account" "monitoring" {
  account_id   = "monitoring-sa"
  display_name = "Grafana Monitoring Service Account"
}

resource "google_project_iam_binding" "monitoring_role" {
  project = var.project_id
  role    = "roles/monitoring.viewer"

  members = [
    "serviceAccount:${google_service_account.monitoring.email}"
  ]
  lifecycle {
    ignore_changes = [
      # List the attributes you want to ignore changes for
      role
    ]
  }
}