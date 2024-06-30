variable "enable_naming" {
  type    = bool
  default = true
}
variable "environment" {
  type = string
}
variable "utility" {
  type = string
}
variable "custom" {
  type = string
}
variable "os_type" {
  type    = string
  default = "focal"
}
variable "node_name" {
  type = string
}
variable "vm_id" {
  type = string
}
variable "unprivileged" {
  type    = string
  default = true
}
variable "network_blocks" {
  type = list(object({
    bridge       = optional(string, "vmbr3")
    ip_address   = string
    gateway      = optional(string, "192.168.2.1")
    name         = optional(string, "")
    enabled      = optional(bool, true)
    mtu          = optional(number, 1500)
    firewall     = optional(bool, true)
    rate_limit   = optional(number, 0)
    subnet_range = optional(number, 24)
  }))
}
variable "dedicated_ram" {
  type    = number
  default = 2048
}
variable "swap" {
  type    = number
  default = 1024
}
variable "storage_pool" {
  type    = string
  default = "Backend-store"
}
variable "disk_size" {
  type    = number
  default = 20
}
variable "cpu_cores" {
  type    = number
  default = 2
}
variable "os" {
  type    = string
  default = "ubuntu"
}
variable "datastore_id" {
  type = string
}