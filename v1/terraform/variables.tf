variable "ssh_public_key" {
    description = "SSH public key for cloud-init"
    type = string
}

variable "proxmox_token_id" {
    description = "Proxmox VE API token ID"
    type = string
    default = "terraform-provider@pve!providerToken"
}

variable "pve1_token_secret" {
    description = "Proxmox VE API token secret for pve1"
    type = string
    sensitive = true
}

variable "pve2_token_secret" {
    description = "Proxmox VE API token secret for pve2"
    type = string
    sensitive = true
}