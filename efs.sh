#!/bin/bash

# Install necessary packages
sudo apt-get update
sudo apt-get install -y nfs-common jq

# Retrieve EFS file system ID and region
efs_id=$(aws efs describe-file-systems --query "FileSystems[0].FileSystemId" --output text)
efs_region=$(aws efs describe-file-systems --query "FileSystems[0].AvailabilityZone" --output text | cut -d'-' -f1)

# Create mount point if it doesn't exist
sudo mkdir -p /var/www/efs-mount

# Check if mount point exists
if [ ! -d "/var/www/efs-mount" ]; then
    echo "Error: Failed to create mount point /var/www/efs-mount"
    exit 1
fi

# Mount EFS file system
sudo mount -t nfs4 ${efs_id}.efs.${efs_region}.amazonaws.com:/ /var/www/efs-mount

# Optional: Add the mount command to /etc/fstab for automatic mounting on boot
echo "${efs_id}.efs.${efs_region}.amazonaws.com:/ /var/www/efs-mount nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" | sudo tee -a /etc/fstab
