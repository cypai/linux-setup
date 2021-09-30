#!/usr/bin/env bash

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add cargo to .bashrc by adding this line:
source $HOME/.cargo/env

# Install rg
cargo install ripgrep
