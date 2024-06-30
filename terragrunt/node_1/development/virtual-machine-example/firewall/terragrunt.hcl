include "root" {
  path = find_in_parent_folders()
}

locals {
  enviroment = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  host       = read_terragrunt_config(find_in_parent_folders("server.hcl"))
  machine    = read_terragrunt_config(find_in_parent_folders("id.hcl"))
}

terraform {
  source = "../../../../../modules/firewall"
}

dependency "virtual_machine" {
  config_path  = "../virtual_machine"
  skip_outputs = true
}

inputs = {
  node_name       = local.host.locals.server_host
  vm_id           = local.machine.locals.vm_id
  enable_controls = true
  log_level_in    = "debug"
  log_level_out   = "debug"
  rules           = []
  inbound_rules   = []
  outbound_rules  = []
}
