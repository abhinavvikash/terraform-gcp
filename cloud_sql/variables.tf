
variable "gcp_pg_name_primary" {
  type    = string
  default = "postgresql-primary"
}


variable "gcp_pg_database_version" {
  type    = string
  default = "POSTGRES_15"
}

variable "gcp_pg_region_primary" {
  type    = string
  default = "europe-west1"
}

variable "project" {
  description = "The project ID where all resources will be launched."
  type        = string
  default     = "playpen-48aa0c"
}


variable "gcp_pg_tier" {
  type    = string
  default = "db-f1-micro"
}

variable vpc_name {
    type = string
    default = "playpen-48aa0c-vpc"
}

variable project_id {
    type = string
    default = "playpen-48aa0c"
}