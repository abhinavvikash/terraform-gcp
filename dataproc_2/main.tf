resource "google_dataproc_cluster" "dpcluster" {
  name                          = var.dataproc_name
  region                        = var.region

  cluster_config {
    staging_bucket = var.bucket_name

    master_config {
      num_instances = 1
      machine_type  = var.dataproc_master_machine_type
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = var.dataproc_master_bootdisk
      }
    }

    worker_config {
      num_instances = var.dataproc_workers_count
      machine_type  = var.dataproc_worker_machine_type
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = var.dataproc_worker_bootdisk
        num_local_ssds    = var.worker_local_ssd
      }
    }

    preemptible_worker_config {
      num_instances = var.preemptible_worker
    }

    software_config {
      image_version = "2.0.66-debian10"
    }

    gce_cluster_config {
      zone = "${var.region}-b"
      subnetwork             = var.subnet_name
      service_account        = var.service_account_name
      service_account_scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/bigquery",
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/devstorage.read_write",
        "https://www.googleapis.com/auth/cloud.useraccounts.readonly"]
      internal_ip_only = true
    }
  }
  
}

