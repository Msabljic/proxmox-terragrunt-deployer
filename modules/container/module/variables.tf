variable "naming_enabled" {
  type    = bool
  default = true
}

variable "map_environments" {
  default = {
    Development = "dev"
    Production  = "prod"
  }
}

variable "environment" {
  type = string

  validation {
    condition     = contains(["Development", "Production"], var.environment)
    error_message = "Utility must contrain either: Development or Production."
  }
}

variable "map_utilities" {
  default = {
    Personal = "prsl"
    Server   = "srv"
    Database = "db"
  }
}

variable "utility" {
  type = string

  validation {
    condition     = contains(["Personal", "Server", "Database"], var.utility)
    error_message = "Utility must contrain either: Personal, Server or Database."
  }
}

variable "map_nodes" {
  default = {
    node_01    = "nd1"
    node_02    = "nd2"
    datacenter = "dcntr"
  }
}

variable "node_name" {
  type = string

  validation {
    condition     = contains(["node_01", "node_02", "datacenter"], var.node_name)
    error_message = "Utility must contrain either: node_01, node_02, datacenter."
  }
}

variable "custom" {
  type    = string
  default = ""
}

variable "map_os_type" {
  default = {
    focal    = "ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
    jammy    = "ubuntu-22.04-standard_22.04-1_amd64.tar.gz"
    bookworm = "debian-12-standard_12.0-1_amd64.tar.zst"
    bullseye = "debian-11-standard_11.7-1_amd64.tar.zst"
  }
}

variable "os_type" {
  type = string

  validation {
    condition     = contains(["focal", "jammy", "bookworm", "bullseye"], var.os_type)
    error_message = "Operating system must contrain either: focal, jammy, bookworm, bullseye."
  }
}