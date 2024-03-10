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

# Step 1: Source the oe-init-build-env script
echo "Step 1: Sourcing the oe-init-build-env script"
source oe-init-build-env
confirm_action

# Step 2: Create a new layer named meta-ke
echo "Step 2: Creating a new layer named meta-ke"
bitbake-layers create-layer ../../meta-ke
confirm_action

# Step 3: Add the new layer to the build configuration
echo "Step 3: Adding the new layer to the build configuration"
bitbake-layers add-layer ../../meta-ke
confirm_action

# Step 4: Show the updated layer configuration
echo "Step 4: Showing the updated layer configuration"
bitbake-layers show-layers
confirm_action

# Step 5: Build the example recipe in the new layer
echo "Step 5: Building the example recipe in the new layer"
bitbake example
confirm_action

# Display a message indicating the completion of the process
echo "New layer creation and addition completed successfully!"
