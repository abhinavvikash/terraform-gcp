variable vpc_name {
    type = string
    default = "playpen-795065-vpc"
}

variable source_ranges {
    type = list
    default = ["10.10.0.0/24"]
}

variable region {
    type = string
    default = "europe-west1"
}

variable project_id {
    type = string
    default = "playpen-795065"
}