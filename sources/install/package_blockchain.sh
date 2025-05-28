#!/bin/bash
# Author: The Exegol Project

source common.sh

function install_foundry() {
    # CODE-CHECK-WHITELIST=add-aliases
    colorecho "Installing foundry"
    # Installation doc: <https://book.getfoundry.sh/getting-started/installation>
    curl -sSL https://foundry.paradigm.xyz -o /tmp/get-foundry.sh
    bash /tmp/get-foundry.sh
    source /root/.zshenv
    foundryup
    # As an other tool called chisel is installed, we rename it to avoid conflicts
    # Luckily, foundry's chisel is not really used a lot :)
    mv /root/.foundry/bin/chisel /root/.foundry/bin/foundry-chisel
    add-history foundry
    add-test-command "forge --help"
    add-test-command "cast --help"
    add-test-command "anvil --help"
    add-test-command "foundry-chisel --help"
    add-to-list "foundry,https://github.com/foundry-rs/foundry,Fast, portable and modular toolkit for Ethereum application development."
}

# Package dedicated to blockchain tools
function package_blockchain() {
    set_env
    local start_time
    local end_time
    start_time=$(date +%s)
    install_foundry
    post_install
    end_time=$(date +%s)
    local elapsed_time=$((end_time - start_time))
    colorecho "Package blockchain completed in $elapsed_time seconds."
}
