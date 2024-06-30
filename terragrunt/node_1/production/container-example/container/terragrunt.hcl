include "root" {
  path = find_in_parent_folders()
}

locals {
  enviroment = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  host       = read_terragrunt_config(find_in_parent_folders("server.hcl"))
  machine    = read_terragrunt_config(find_in_parent_folders("id.hcl"))
}

terraform {
  source = "../../../../../modules/container"
}

inputs = {
  enable_naming = true
  environment   = local.enviroment.locals.enviroment
  utility       = "Server"
  custom        = "test"
  node_name     = local.host.locals.server_host
  vm_id         = local.machine.locals.vm_id
  cpu_cores     = 4
  dedicated_ram = 8192
  startup_order = 2
  network_blocks = [
    {
      bridge       = "vmbr2"
      ip_address   = "10.0.0.4"
      gateway      = "10.0.0.1"
      subnet_range = 28
      mtu          = 1500
  }]
}
