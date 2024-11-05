variable "dataproc_master_machine_type" {
  type        = string
  description = "dataproc master node machine tyoe"
  default     = "e2-standard-2"
}

variable "dataproc_worker_machine_type" {
  type        = string
  description = "dataproc worker nodes machine type"
  default     = "e2-standard-2"
}

variable "dataproc_workers_count" {
  type        = number
  description = "count of worker nodes in cluster"
  default     = 2
}
variable "dataproc_master_bootdisk" {
  type        = number
  description = "primary disk attached to master node, specified in GB"
  default     = 500
}

variable "dataproc_worker_bootdisk" {
  type        = number
  description = "primary disk attached to master node, specified in GB"
  default     = 500
}

variable "worker_local_ssd" {
  type        = number
  description = "primary disk attached to master node, specified in GB"
  default     = 0
}

variable "preemptible_worker" {
  type        = number
  description = "number of preemptible nodes to create"
  default     = 2
}

variable "dataproc_name" {
  type    = string
  default = "dp-cluster"
}

variable service_account_name {
  type = string
  default = "dataproc-svc@playpen-795065.iam.gserviceaccount.com"
}

variable bucket_name {
  type = string
  default = "playpen-795065-dataproc-bucket"
}

variable region {
  type = string
  default = "europe-west1"
}

variable subnet_name {
  type = string
  default = "playpen-795065-subnet-dp"
}

variable vpc_name {
  type = string
  default = "playpen-795065-vpc"
}

variable project_id {
  type = string
  default = "playpen-795065"
}
