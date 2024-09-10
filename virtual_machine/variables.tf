variable vpc_name {
    type = string
    default = "playpen-e16de4-vpc"
}

variable project_id {
    type = string
    default = "playpen-e16de4"
}

variable vm_name {
    type = string
    default = "foundation-component-vm"
}

variable zone {
    type = string
    default = "europe-west1-b"
}

variable machine_type {
    type = string
    default = "n1-standard-1"
}

variable region {
    type = string
    default = "europe-west1"
}

variable subnet_vm {
  type = string
  default = "playpen-e16de4-subnet"
}