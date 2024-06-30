include "root" {
  path = find_in_parent_folders()
}

locals {
  enviroment = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  host       = read_terragrunt_config(find_in_parent_folders("server.hcl"))
  machine    = read_terragrunt_config(find_in_parent_folders("id.hcl"))
}

terraform {
  source = "../../../../../modules/virtual_machine"
}

inputs = {
  enable_naming = true
  environment   = local.enviroment.locals.enviroment
  utility       = "Database"
  custom        = "mysql"
  node_name     = local.host.locals.server_host
  vm_id         = local.machine.locals.vm_id
  cpu_cores     = 2
  dedicated_ram = 4096
  startup_order = 2
  ip_config = [
    {
      bridge       = "vmbr0"
      ip_address   = "192.168.0.4"
      gateway      = "192.168.0.1"
      subnet_range = 26
      mtu          = 1450
  }]
}
