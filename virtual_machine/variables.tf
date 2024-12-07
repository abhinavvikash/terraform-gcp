variable vpc_name {
    type = string
    default = "playpen-2f4e18-vpc"
}

variable project_id {
    type = string
    default = "playpen-2f4e18"
}

variable vm_name {
    type = string
    default = "foundation-component-vm"
}

variable zone {
    type = string
    default = "europe-central2-b"
}

variable machine_type {
    type = string
    default = "n1-standard-1"
}

variable region {
    type = string
    default = "europe-central2"
}

variable subnet_vm {
  type = string
  default = "playpen-2f4e18-subnet-dp"
}