
variable "gcp_pg_name_primary" {
  type    = string
  default = "postgresql-primary"
}


variable "gcp_pg_database_version" {
  type    = string
  default = "POSTGRES_15"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "zone" {
  type = string
  default = "europe-west1-a"
}

variable "gcp_pg_tier" {
  type    = string
  default = "db-f1-micro"
}

variable vpc_name {
    type = string
    default = "playpen-e16de4-vpc"
}

variable project_id {
    type = string
    default = "playpen-e16de4"
}

variable username {
  type = string
  default = "admin"
}

variable password {
  type = string
  default = "admin"
}