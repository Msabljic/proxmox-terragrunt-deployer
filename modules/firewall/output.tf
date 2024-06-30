output "firewall_rules" {
  value = proxmox_virtual_environment_firewall_rules.this
}

output "firewall_config" {
  value = proxmox_virtual_environment_firewall_options.this
}