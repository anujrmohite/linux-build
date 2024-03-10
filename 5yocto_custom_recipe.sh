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

# Step 2: Create a new folder for the custom recipe within the meta-ke layer
echo "Step 2: Creating a new folder for the custom recipe"
mkdir -p meta-ke/recipes-ke/hwlocal/files
confirm_action

# Step 3: Create the hello-world-local.c source code file
echo "Step 3: Creating the hello-world-local.c source code file"
echo '#include <stdio.h>

int main(void) {
    printf("Hello, World!\r\n");
    return 0;
}' > meta-ke/recipes-ke/hwlocal/files/hello-world-local.c
confirm_action

# Step 4: Create the hwlocal_0.1.bb recipe file
echo "Step 4: Creating the hwlocal_0.1.bb recipe file"
echo 'DESCRIPTION = "This is a simple Hello World recipe - uses a local source file"
HOMEPAGE = "https://kickstartembedded.com"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://hello-world-local.c"

S = "${WORKDIR}"

do_compile() {
    ${CC} ${LDFLAGS} hello-world-local.c -o hello-world-local
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 hello-world-local ${D}${bindir}
}' > meta-ke/recipes-ke/hwlocal/hwlocal_0.1.bb
confirm_action

# Display a message indicating the completion of the process
echo "Custom recipe creation completed successfully!"
