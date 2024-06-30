output "virtual_machine_name" {
  value = local.vm.name
}

output "container_name" {
  value = local.lxc.name
}

output "Network_interface_name_mgmt" {
  value = local.nic_mgmt.name
}

output "Network_interface_name_gen" {
  value = local.nic_gen.name
}

output "node_name" {
  value = local.nic_gen.name
}

output "list_of_tags" {
  value = local.tags_as_list.name
}

output "naming_enabled" {
  value = local.enabled_0
}

output "username" {
  value = local.username.name
}

