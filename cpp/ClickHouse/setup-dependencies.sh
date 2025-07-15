#!/bin/bash

# ClickHouse Specific Dependencies
apt-get update
apt-get install -y git cmake ccache python3 ninja-build nasm yasm gawk lsb-release wget software-properties-common gnupg

# clang
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh