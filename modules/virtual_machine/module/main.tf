locals {
  ### Defining naming standards for resources within the given configuration ###
  enabled_0   = var.naming_enabled
  environment = var.environment
  utility     = var.utility
  open_string = var.custom
  node        = var.node_name
  delimiter   = "-"

  mapper = {
    environment = lookup(var.map_environments, local.environment, "")
    utility     = lookup(var.map_utilities, local.utility, "")
    node        = lookup(var.map_nodes, local.node, "")
  }
  vm = {
    name = lower(join(local.delimiter, ["vm", local.mapper.environment, local.mapper.utility, local.open_string]))
  }
  lxc = {
    name = lower(join(local.delimiter, ["ct", local.mapper.environment, local.mapper.utility, local.open_string]))
  }
  nic_mgmt = {
    name = lower(join(local.delimiter, ["nic", local.mapper.node, "mgmt"]))
  }
  nic_gen = {
    name = lower(join(local.delimiter, ["nic", local.mapper.node, "gen"]))
  }
  tags_as_list = {
    name = tolist([lower(var.environment), lower(var.utility), lower(var.node_name)])
  }
  username = {
    name = lower(join("-", [local.mapper.environment, local.mapper.utility, "admin"]))
  }
}
