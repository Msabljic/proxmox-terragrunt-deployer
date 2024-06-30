generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~>0.55"
    }
  }
}
provider "proxmox" {
  insecure = true
  endpoint = "proxmox_cluster_endpoint"
  username = "service_account@example"
  password = "your_password"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {
    encrypt                     = false
    endpoint                    = "add_your_endpoint"
    access_key                  = "add_your_access_key"
    secret_key                  = "add_your_secret_key"
    bucket                      = "proxmox"
    key                         = "states/${path_relative_to_include()}/terraform.tfstate"
    region                      = "ca-central-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
  }
EOF
}
