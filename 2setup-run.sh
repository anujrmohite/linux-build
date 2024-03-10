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

# Step 1: Create a working directory
echo "Step 1: Creating a working directory"
mkdir -p ~/yocto
cd ~/yocto
confirm_action

# Step 2: Download Poky and select the desired release (Dunfell)
echo "Step 2: Downloading Poky and selecting the Dunfell release"
git clone git://git.yoctoproject.org/poky
cd poky
git checkout -b dunfell origin/dunfell
confirm_action

# Step 3: Create the active build directory
echo "Step 3: Creating the active build directory"
build_dir="build"  # You can change this to your preferred directory name
source oe-init-build-env "$build_dir"
confirm_action

# Step 4: Start the first build (Fetch resources)
echo "Step 4: Starting the first build (Fetching resources)"
bitbake core-image-sato --runall=fetch
confirm_action

# Step 5: Start the actual build
echo "Step 5: Starting the actual build"
bitbake core-image-sato
confirm_action

# Step 6: Run the image using runqemu
output_folder="tmp/deploy/images/qemux86-64"
runqemu_cmd="runqemu qemux86-64 nographic"
echo "Step 6: Running the image using runqemu"
echo "Output folder: $(pwd)/$output_folder"
confirm_action
$runqemu_cmd
