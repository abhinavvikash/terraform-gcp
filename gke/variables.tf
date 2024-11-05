 variable gke_num_nodes {
  type = number
  default     = 1
  description = "number of gke nodes"
}

variable region {
    type = string
    default = "europe-west1"
}

variable project_id {
    type = string
    default = "playpen-795065"
}

variable vpc_name {
    type = string
    default = "playpen-795065-vpc"
}

variable subnet_name {
    type = string
    default = "playpen-795065-subnet-gke"
}

variable machine_type {
    type = string
    default = "n1-standard-4"
}

variable master_authorized_networks_ips {
    type = string
    default = "148.64.30.0/24"
}

variable gke_username {
    type = string
    default = "admin"
}

variable gke_password {
    type = string
    default = "admin"
}
 