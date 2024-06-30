variable "enable_naming" {
  type    = bool
  default = true
}
variable "node_name" {
  type = string
}
variable "datastore_id" {
  type    = string
  default = "local-lvm"
}
variable "vm_id" {
  type    = number
  default = 100
}
variable "start_after_deploy" {
  type    = bool
  default = false
}
variable "startup_order" {
  type    = number
  default = 4
}
variable "cpu_cores" {
  type    = number
  default = 4
}
variable "flags" {
  type    = list(string)
  default = []
}
variable "cpu_units" {
  type    = number
  default = 500
}
variable "dedicated_ram" {
  type    = number
  default = 4096
}
variable "storage_pool" {
  type    = string
  default = "local-lvm"
}
variable "disk_size" {
  type    = number
  default = 25
}
variable "dhcp" {
  type    = bool
  default = true
}
variable "enabled" {
  type    = bool
  default = true
}
variable "custom" {
  type    = string
  default = "custom"
}
variable "environment" {
  type    = string
  default = "Development"
}
variable "utility" {
  type    = string
  default = "Test"
}
variable "type" {
  type    = string
  default = "Server"
}
variable "nic_enabled" {
  type    = bool
  default = true
}
variable "ip_config" {
  type = list(object({
    bridge       = optional(string, "vmbr0")
    subnet_range = optional(number, 24)
    ip_address   = string
    gateway      = optional(string, "10.0.0.1")
    mtu          = optional(number, 1500)
  }))
}
variable "datastore" {
  type = string
}
variable "datastore_node" {
  type = string
}
variable "clone_id" {
  type = number
}