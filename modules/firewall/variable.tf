variable "enable_controls" {
  type    = bool
  default = false
}
variable "node_name" {
  type    = string
  default = null
}
variable "vm_id" {
  type    = number
  default = null
}
variable "dhcp" {
  type    = bool
  default = true
}
variable "enabled" {
  type    = bool
  default = true
}
variable "ipfilter" {
  type    = bool
  default = false
}
variable "log_level_in" {
  type    = string
  default = "nolog"
}
variable "log_level_out" {
  type    = string
  default = "nolog"
}
variable "macfilter" {
  type    = bool
  default = true
}
variable "ndp" {
  type    = bool
  default = true
}
variable "input_policy" {
  type    = string
  default = "DROP"
}
variable "output_policy" {
  type    = string
  default = "ACCEPT"
}
variable "radv" {
  type    = bool
  default = false
}

variable "rules" {
  type = list(object({
    sg_name   = optional(string, null)
    comment   = optional(string, null)
    interface = optional(string, null)
  }))
}

variable "inbound_rules" {
  type = list(object({
    enabled          = optional(string, true)
    interface        = optional(string, "")
    action           = optional(string, "DROP")
    comment          = optional(string, "Default comment")
    destination      = optional(string, "")
    destination_port = optional(string, "")
    source           = optional(string, "")
    source_port      = optional(string, "")
    protocol         = optional(string, "")
    macro            = optional(string, "")
    log              = optional(string, "nolog")
  }))
}

variable "outbound_rules" {
  type = list(object({
    enabled          = optional(string, true)
    interface        = optional(string, "")
    action           = optional(string, "DROP")
    comment          = optional(string, "Default comment")
    destination      = optional(string, "")
    destination_port = optional(string, "")
    source           = optional(string, "")
    source_port      = optional(string, "")
    protocol         = optional(string, "")
    macro            = optional(string, "")
    log              = optional(string, "nolog")
  }))
}