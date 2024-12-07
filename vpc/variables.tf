variable vpc_name {
    type = string
    default = "playpen-2f4e18-vpc"
}

variable dataproc_subnet_name {
    type = string
    default = "playpen-2f4e18-subnet-dp"
}

variable region {
    type = string
    default = "europe-central2"
}

variable gke_subnet_name {
    type = string
    default = "playpen-2f4e18-subnet-gke"
}

variable project_id {
    type = string
    default = "playpen-2f4e18"
}