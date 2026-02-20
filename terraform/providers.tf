terraform {
    required_providers {
      proxmox = {
        source = "telmate/proxmox"
        version = "3.0.1-rc1"
      }
    }
}

provider "pve1" {
    pm_api_url = "https://192.168.132.201:8006/api2/json"
    pm_user = "root@pam"
    pm_password = var.proxmox_password
    pm_tls_insecure = true
}

provider "pve2" {
    pm_api_url = "https://192.168.132.202:8006/api2/json"
    pm_user = "root@pam"
    pm_password = var.proxmox_password
    pm_tls_insecure = true
}