variable vpc_name {
    type = string
    default = "playpen-742d6a-vpc"
}

variable subnet_name {
    type = string
    default = "playpen-742d6a-subnet"
}

variable region {
    type = string
    default = "europe-west1"
}

variable gke_subnet_name {
    type = string
    default = "playpen-742d6a-subnet-gke"
}