#!/bin/bash

# Function to confirm user action
confirm_action() {
    read -r -p "Do you want to continue? (y/n): " response
    case "$response" in
        [yY]) 
            return 0
            ;;
        *)
            echo "Script aborted."
            exit 1
            ;;
    esac
}

# Step 1: Set up the build environment
echo "Step 1: Setting up the build environment"
source oe-init-build-env build-rpi
confirm_action

# Step 2: Add necessary layers
echo "Step 2: Adding necessary layers"
bitbake-layers add-layer ./meta-openembedded
bitbake-layers add-layer ./meta-raspberrypi
bitbake-layers add-layer ./meta-openembedded/meta-oe
bitbake-layers add-layer ./meta-openembedded/meta-python
bitbake-layers add-layer ./meta-openembedded/meta-networking
bitbake-layers add-layer ./meta-openembedded/meta-multimedia
confirm_action

# Step 3: Set the machine variable to raspberrypi4
echo "Step 3: Setting the machine variable to raspberrypi4"
cd poky/build-rpi
sed -i 's/MACHINE ??= "qemux86-64"/MACHINE ??= "raspberrypi4"/' conf/local.conf
confirm_action

# Step 4: Optionally enable UART for Raspberry Pi 4
echo "Step 4: Optionally enabling UART for Raspberry Pi 4"
echo "ENABLE_UART = \"1\"" >> conf/local.conf
confirm_action

# Step 5: Fetch necessary resources
echo "Step 5: Fetching necessary resources"
bitbake rpi-test-image --runall=fetch
confirm_action

# Step 6: Build the image
echo "Step 6: Building the image"
bitbake rpi-test-image
confirm_action

# Display a message indicating the completion of the build process
echo "Yocto build for Raspberry Pi 4 completed successfully!"
