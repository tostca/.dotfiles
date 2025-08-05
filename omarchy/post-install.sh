#!/bin/bash

# Copy ssh config

# Ensure required folders exists
cd ~
mkdir -p work
mkdir -p personal
mkdir -p customers
mkdir -p .local/bin
mkdir -p tools/themes

# Additional packages for development

yay -S --noconfirm --needed \
  tmux starship television jnv xan \
  stow openfortivpn direnv \
  visual-studio-code-bin \
  microsoft-edge-stable-bin

# Install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# clone dotfiles
git clone git@github.com:tostca/.dotfiles.git ~/.dotfiles

# clone dotfiles priv
git clone git@github.com:tostca/.dotfiles-private.git ~/.dotfiles-private

cp ~/.dotfiles/bin/.local/bin/tmux-sessionizer ~/.local/bin/
