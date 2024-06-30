resource "proxmox_virtual_environment_firewall_options" "this" {
  count = var.enable_controls ? 1 : 0

  node_name = var.node_name
  vm_id     = var.vm_id

  dhcp          = var.dhcp
  enabled       = var.enabled
  ipfilter      = var.ipfilter
  log_level_in  = var.log_level_in
  log_level_out = var.log_level_out
  macfilter     = var.macfilter
  ndp           = var.ndp
  input_policy  = var.input_policy
  output_policy = var.output_policy
  radv          = var.radv
}

resource "proxmox_virtual_environment_firewall_rules" "this" {
  node_name = var.node_name
  vm_id     = var.vm_id

  dynamic "rule" {
    for_each = { for rule in var.rules : rule.sg_name => rule if length(var.rules) > 0 }
    content {
      security_group = rule.value.sg_name
      comment        = rule.value.comment
      iface          = rule.value.interface
    }
  }

  dynamic "rule" {
    for_each = { for rule in var.inbound_rules : join("-", [rule.comment, rule.macro, rule.protocol, rule.log]) => rule if length(var.inbound_rules) > 0 }
    content {
      type    = "in"
      enabled = rule.value.enabled
      iface   = rule.value.interface
      action  = rule.value.action
      comment = rule.value.comment
      dest    = rule.value.destination
      dport   = rule.value.destination_port
      source  = rule.value.source
      sport   = rule.value.source_port
      proto   = rule.value.protocol
      macro   = rule.value.macro
      log     = rule.value.log
    }
  }

  dynamic "rule" {
    for_each = { for rule in var.outbound_rules : join("-", [rule.comment, rule.macro, rule.protocol, rule.log]) => rule if length(var.outbound_rules) > 0 }
    content {
      type    = "out"
      enabled = rule.value.enabled
      iface   = rule.value.interface
      action  = rule.value.action
      comment = rule.value.comment
      dest    = rule.value.destination
      dport   = rule.value.destination_port
      source  = rule.value.source
      sport   = rule.value.source_port
      proto   = rule.value.protocol
      macro   = rule.value.macro
      log     = rule.value.log
    }
  }
  depends_on = [proxmox_virtual_environment_firewall_options.this]
}
