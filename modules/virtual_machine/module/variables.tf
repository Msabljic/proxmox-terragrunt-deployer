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
    error_message = "Utility must contrain either: Development, Production."
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
    error_message = "Utility must contrain either: Personal, Server, Database."
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