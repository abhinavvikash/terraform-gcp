variable vpc_name {
    type = string
    default = "playpen-e16de4-vpc"
}

variable dataproc_subnet_name {
    type = string
    default = "playpen-e16de4-subnet"
}

variable region {
    type = string
    default = "europe-west1"
}

variable gke_subnet_name {
    type = string
    default = "playpen-e16de4-subnet-gke"
}

variable project_id {
    type = string
    default = "playpen-e16de4"
}