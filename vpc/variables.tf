variable vpc_name {
    type = string
    default = "playpen-48aa0c-vpc"
}

variable subnet_name {
    type = string
    default = "playpen-48aa0c-subnet"
}

variable region {
    type = string
    default = "europe-west1"
}

variable gke_subnet_name {
    type = string
    default = "playpen-48aa0c-subnet-gke"
}