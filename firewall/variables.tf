variable vpc_name {
    type = string
    default = "playpen-48aa0c-vpc"
}

variable source_ranges {
    type = list
    default = ["10.10.0.0/24"]
}