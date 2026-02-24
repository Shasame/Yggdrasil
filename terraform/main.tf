resource "proxmox_vm_qemu" "yggdrassil_master" {
    provider = proxmox.pve1
    name = "yggdrassil-master"
    target_node = "pve1"
    clone = "ubuntu-24-04-template"
    full_clone = true
    vmid = 100
    memory = 4096

    scsihw = "virtio-scsi-pci"
    boot = "order=scsi0"

    cpu {
        cores = 2
        sockets = 1
    }

    disk {
        size = "50G"
        type = "disk"
        storage = "local-lvm"
        slot = "scsi0"
    }
    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
    }

    serial {
        id = 0
        type = "socket"
    }
    vga {
        type = "serial0"
    }

    os_type = "cloud-init"
    ciuser = "ubuntu"
    ipconfig0 = "ip=192.168.1.203/24,gw=192.168.1.254"
    sshkeys = <<EOF
    ${var.ssh_public_key}
    EOF
}

resource "proxmox_vm_qemu" "yggdrassil_worker" {
    provider = proxmox.pve2
    name = "yggdrassil-worker"
    target_node = "pve2"
    clone = "ubuntu-24-04-template"
    full_clone = true
    vmid = 100
    memory = 4096

    scsihw = "virtio-scsi-pci"
    boot = "order=scsi0"
    
    cpu {
        cores = 2
        sockets = 1
    }

    disk {
        size = "50G"
        type = "disk"
        storage = "local-lvm"
        slot = "scsi0"
    }
    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
    }

    serial {
        id = 0
        type = "socket"
    }
    vga {
        type = "serial0"
    }

    os_type = "cloud-init"
    ciuser = "ubuntu"
    ipconfig0 = "ip=192.168.1.204/24,gw=192.168.1.254"
    sshkeys = <<EOF
    ${var.ssh_public_key}
    EOF
}