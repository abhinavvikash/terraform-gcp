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
    default = "playpen-742d6a"
}

variable vpc_name {
    type = string
    default = "playpen-742d6a-vpc"
}

variable subnet_name {
    type = string
    default = "playpen-742d6a-subnet-gke"
}

variable machine_type {
    type = string
    default = "n1-standard-1"
}

variable master_authorized_networks_ips {
    type = string
    default = "148.64.28.25/32"
}
 