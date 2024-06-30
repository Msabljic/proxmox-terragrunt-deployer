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

dependency "container" {
  config_path  = "../container"
  skip_outputs = true
}

inputs = {
  node_name       = local.host.locals.server_host
  vm_id           = local.machine.locals.vm_id
  enable_controls = true
  rules           = []
  inbound_rules   = []
  outbound_rules  = []
}
