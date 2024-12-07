variable vpc_name {
    type = string
    default = "playpen-2f4e18-vpc"
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
    default = "playpen-2f4e18"
}