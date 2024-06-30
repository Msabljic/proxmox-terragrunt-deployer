module "naming" {
  source         = "./module"
  environment    = var.environment
  utility        = var.utility
  custom         = var.custom
  node_name      = var.node_name
  naming_enabled = var.enable_naming
}

resource "proxmox_virtual_environment_vm" "this" {
  name        = module.naming.virtual_machine_name
  description = <<EOT
# Machine Information & Specifications.

Admin account

${module.naming.username}

${random_password.this.result}
EOT
  tags        = module.naming.list_of_tags
  node_name   = var.node_name
  vm_id       = var.vm_id
  started     = false

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.dedicated_ram
  }

  agent {
    enabled = true
  }

  clone {
    datastore_id = var.datastore
    vm_id        = var.clone_id
    node_name    = var.datastore_node
    retries      = 5
  }

  initialization {
    datastore_id = var.datastore
    user_account {
      username = module.naming.username
      password = random_password.this.result
      keys     = [trimspace(tls_private_key.ubuntu_vm_key.public_key_openssh)]
    }

    dynamic "ip_config" {
      for_each = { for ip in var.ip_config : ip.ip_address => ip }
      content {
        ipv4 {
          address = "${ip_config.value.ip_address}/${ip_config.value.subnet_range}"
          gateway = ip_config.value.gateway
        }
      }
    }
  }

  dynamic "network_device" {
    for_each = { for ip in var.ip_config : ip.ip_address => ip }
    content {
      bridge   = network_device.value.bridge
      firewall = true
      mtu      = network_device.value.mtu
    }
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}

resource "random_password" "this" {
  length           = 16
  override_special = "_%@"
  special          = true
}

resource "tls_private_key" "ubuntu_vm_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "proxmox_virtual_environment_firewall_alias" "network_alias" {
  for_each = { for ip in var.ip_config : ip.ip_address => ip }
  name     = "${module.naming.virtual_machine_name}-${each.value.bridge}"
  cidr     = each.value.ip_address
  comment  = "${var.vm_id} ${var.environment} ${var.custom}"

  depends_on = [proxmox_virtual_environment_vm.this]
}