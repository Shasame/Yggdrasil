terraform {
    required_providers {
      proxmox = {
        source = "telmate/proxmox"
        version = "3.0.2-rc04"
      }
    }
}

provider "proxmox" {
  alias = "pve1"
  pm_api_url = "https://192.168.1.201:8006/api2/json"
  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.pve1_token_secret
  pm_tls_insecure = true
}

provider "proxmox" {
  alias = "pve2"
  pm_api_url = "https://192.168.1.202:8006/api2/json"
  pm_api_token_id = var.proxmox_token_id
  pm_api_token_secret = var.pve2_token_secret
  pm_tls_insecure = true
}