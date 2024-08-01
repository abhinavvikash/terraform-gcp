variable vpc_name {
    type = string
    default = "playpen-742d6a-vpc"
}

variable source_ranges {
    type = list
    default = ["10.10.0.0/24"]
}