module "naming" {
  source         = "./module"
  environment    = var.environment
  utility        = var.utility
  custom         = var.custom
  node_name      = var.node_name
  naming_enabled = var.enable_naming
  os_type        = var.os_type
}

resource "proxmox_virtual_environment_container" "this" {
  node_name    = var.node_name
  vm_id        = var.vm_id
  tags         = module.naming.list_of_tags
  pool_id      = var.environment
  unprivileged = var.unprivileged
  started      = true
  description  = <<EOT
# Machine Information & Specifications.

Admin account

${module.naming.username}

${random_password.this.result}
EOT
  initialization {
    hostname = module.naming.container_name

    dynamic "ip_config" {
      for_each = { for network in var.network_blocks : network.bridge => network }
      content {
        ipv4 {
          address = "${ip_config.value.ip_address}/${ip_config.value.subnet_range}"
          gateway = ip_config.value.gateway
        }
      }
    }
    user_account {
      keys     = [trimspace(tls_private_key.this.public_key_openssh)]
      password = random_password.this.result
    }
  }

  memory {
    dedicated = var.dedicated_ram
    swap      = var.swap
  }

  disk {
    datastore_id = var.storage_pool
    size         = var.disk_size
  }

  cpu {
    cores = var.cpu_cores
  }

  dynamic "network_interface" {
    for_each = { for network in var.network_blocks : network.bridge => network }
    content {
      name       = module.naming.Network_interface_name_gen
      bridge     = network_interface.value.bridge
      enabled    = network_interface.value.enabled
      mtu        = network_interface.value.mtu
      firewall   = network_interface.value.firewall
      rate_limit = network_interface.value.rate_limit
    }
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_file.ubuntu_container_template.id
    type             = var.os
  }

  features {
    nesting = true
  }
  depends_on = [module.naming]
}

resource "proxmox_virtual_environment_file" "ubuntu_container_template" {
  content_type = "vztmpl"
  datastore_id = var.datastore_id
  node_name    = var.node_name

  source_file {
    path = module.naming.operating_system
  }
}

resource "random_password" "this" {
  length           = 24
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "proxmox_virtual_environment_firewall_alias" "network_alias" {
  for_each = { for ip in var.network_blocks : ip.ip_address => ip }
  name     = "${module.naming.virtual_machine_name}-${each.value.bridge}"
  cidr     = each.value.ip_address
  comment  = "${var.vm_id} ${var.environment} ${var.custom}"

  depends_on = [proxmox_virtual_environment_container.this]
}