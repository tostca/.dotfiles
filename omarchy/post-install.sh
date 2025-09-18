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
  visual-studio-code-bin typtea \
  microsoft-edge-stable-bin remmina freerdp

# Install tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# clone dotfiles
git clone git@github.com:tostca/.dotfiles.git ~/.dotfiles

# clone dotfiles priv
git clone git@github.com:tostca/.dotfiles-private.git ~/.dotfiles-private

cp ~/.dotfiles/bin/.local/bin/tmux-sessionizer ~/.local/bin/

# stow config files
cd ~/.dotfiles
stow nvim-lazy
stow tmux
stow mise

# remove omarchy default ~/.bashrc before stow
stow bash

# dotnet

# Install dotnet 8 and 9 from microsoft scripts
# this ensures that `roslyn` lsp work properly.
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script
#
# download script

wget https://dot.net/v1/dotnet-install.sh -O ~/tools/dotnet-install.sh
chmod +x ~/tools/dotnet-install.sh
~/tools/dotnet-install.sh --channel STS
~/tools/dotnet-install.sh --channel LTS

# Install Azure DevOps Artifacts Credentials Provider
# https://github.com/microsoft/artifacts-credprovider?tab=readme-ov-file#installation-on-linux-and-mac
wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash

# Go to the Azure DevOps Artifacts page and add the feed.
# Authenticate by running below command.
dotnet nuget add source <https://CUSTOM_FEED_URL> -n <NAME_OF_THE_FEED>
dotnet restore --interactive
