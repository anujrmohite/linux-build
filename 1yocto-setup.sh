#!/bin/bash
echo "Adding Support for Jenkins"
log_file="yocto_setup.log"

# Function to log messages
log() {
    echo "$1" | tee -a "$log_file"
}

# Check if apt is available
if ! command -v apt &> /dev/null; then
    log "This script is designed for systems that use APT as the package manager."
    exit 1
fi

# Step 1: Update package manager
log "Step 1: Updating package manager"
sudo apt update | tee -a "$log_file"

# Step 2: Install essential tools
log "Step 2: Installing essential tools"
sudo apt install git git-lfs tar python3 python3-pip gcc | tee -a "$log_file"

# Step 3: Install essential packages for Yocto builds
log "Step 3: Installing essential packages for Yocto builds"
sudo apt install gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev zstd liblz4-tool | tee -a "$log_file"

# Step 4: Install optional documentation packages
log "Step 4: Installing optional documentation packages"
sudo apt install make python3-pip | tee -a "$log_file"
sudo pip3 install sphinx sphinx_rtd_theme pyyaml | tee -a "$log_file"

log "Yocto setup on Ubuntu completed successfully!"
