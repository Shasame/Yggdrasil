#!/bin/bash
set -e  # Exit immediately if a command fails

# --- CONFIGURATION ---
# List of Proxmox Nodes IPs
NODES=("192.168.1.201" "192.168.1.202")

# Template Settings
TEMPLATE_ID="9000"
TEMPLATE_NAME="ubuntu-24-04-template"
IMAGE_URL="https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
IMAGE_NAME="ubuntu-24.04.img"

# Storage Name (Check your Proxmox GUI: Datacenter -> Storage)
# On a default Ext4 install, this is usually 'local-lvm'.
STORAGE="local-lvm" 

# --- THE FUNCTION ---
create_template_on_node() {
    local TARGET_IP=$1
    echo "========================================"
    echo "Processing Node: $TARGET_IP"
    echo "========================================"

    # 1. Download Image (Only if not already there to save bandwidth)
    echo "Checking for image..."
    ssh root@$TARGET_IP "if [ ! -f /tmp/$IMAGE_NAME ]; then wget -qO /tmp/$IMAGE_NAME $IMAGE_URL; fi"

    # 2. Cleanup Old Template (Idempotency)
    echo "Destroying old template (if exists)..."
    ssh root@$TARGET_IP "qm stop $TEMPLATE_ID 2>/dev/null || true"
    ssh root@$TARGET_IP "qm destroy $TEMPLATE_ID --purge 2>/dev/null || true"

    # 3. Create VM Shell
    echo "Creating VM $TEMPLATE_ID..."
    ssh root@$TARGET_IP "qm create $TEMPLATE_ID --name $TEMPLATE_NAME --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0"

    # 4. Import Disk
    echo "Importing Disk to $STORAGE..."
    ssh root@$TARGET_IP "qm importdisk $TEMPLATE_ID /tmp/$IMAGE_NAME $STORAGE"

    # 5. Configure Hardware
    # Attach the imported disk as the boot drive (scsi0)
    ssh root@$TARGET_IP "qm set $TEMPLATE_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$TEMPLATE_ID-disk-0"
    
    # Set boot order
    ssh root@$TARGET_IP "qm set $TEMPLATE_ID --boot c --bootdisk scsi0"

    # Add Cloud-Init Drive (The configuration magic)
    ssh root@$TARGET_IP "qm set $TEMPLATE_ID --ide2 $STORAGE:cloudinit"

    # Enable Serial Console (Required for Cloud-Init logs to show up in Proxmox UI)
    ssh root@$TARGET_IP "qm set $TEMPLATE_ID --serial0 socket --vga serial0"

    # 6. Convert to Template
    echo "Converting to Template..."
    ssh root@$TARGET_IP "qm template $TEMPLATE_ID"

    echo "✅ Node $TARGET_IP configured successfully."
}

# --- EXECUTION LOOP ---
for node in "${NODES[@]}"; do
    create_template_on_node $node
done

echo "🎉 All nodes updated!"