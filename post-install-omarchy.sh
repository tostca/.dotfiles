#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Post-Install Script for Omarchy ===${NC}"
echo ""

# Check if yay is installed
if ! command -v yay &>/dev/null; then
	echo -e "${RED}Error: yay is not installed. Please install yay first.${NC}"
	exit 1
fi

# Pacman packages to install
PACMAN_PACKAGES=(
	direnv
	freerdp
	jnv
	openfortivpn
	remmina
	starship
	stow
	television
	tmux
	xan
)

# AUR packages to install
AUR_PACKAGES=(
	doggo-bin
	hpuld
	lazysql
	lazyssh-bin
	microsoft-edge-stable-bin
	postman-bin
	powershell-bin
	remmina-plugin-rdesktop
	soapui
	typtea
	visual-studio-code-bin
)

echo -e "${YELLOW}Installing Pacman packages...${NC}"
for pkg in "${PACMAN_PACKAGES[@]}"; do
	if pacman -Q "$pkg" &>/dev/null; then
		echo -e "  ${GREEN}✓${NC} $pkg already installed"
	else
		echo -e "  ${YELLOW}→${NC} Installing $pkg..."
		sudo pacman -S --noconfirm --needed "$pkg"
	fi
done

echo ""
echo -e "${YELLOW}Installing AUR packages...${NC}"
for pkg in "${AUR_PACKAGES[@]}"; do
	if pacman -Q "$pkg" &>/dev/null; then
		echo -e "  ${GREEN}✓${NC} $pkg already installed"
	else
		echo -e "  ${YELLOW}→${NC} Installing $pkg..."
		yay -S --noconfirm --needed "$pkg"
	fi
done

echo ""
echo -e "${YELLOW}Setting up dotfiles...${NC}"

# Ensure required directories exist
mkdir -p ~/work
mkdir -p ~/personal
mkdir -p ~/customers
mkdir -p ~/.local/bin
mkdir -p ~/tools/themes

# Clone dotfiles if not already present
if [ ! -d "$HOME/.dotfiles" ]; then
	echo -e "  ${YELLOW}→${NC} Cloning .dotfiles repository..."
	git clone git@github.com:tostca/.dotfiles.git ~/.dotfiles
else
	echo -e "  ${GREEN}✓${NC} .dotfiles repository already exists"
fi

if [ ! -d "$HOME/.dotfiles-private" ]; then
	echo -e "  ${YELLOW}→${NC} Cloning .dotfiles-private repository..."
	git clone git@github.com:tostca/.dotfiles-private.git ~/.dotfiles-private
else
	echo -e "  ${GREEN}✓${NC} .dotfiles-private repository already exists"
fi

# Copy tmux-sessionizer
if [ -f "$HOME/.dotfiles/bin/.local/bin/tmux-sessionizer" ]; then
	cp ~/.dotfiles/bin/.local/bin/tmux-sessionizer ~/.local/bin/
	echo -e "  ${GREEN}✓${NC} tmux-sessionizer copied to ~/.local/bin/"
fi

# Stow config files
echo ""
echo -e "${YELLOW}Stowing configuration files...${NC}"
cd ~/.dotfiles

if [ -d "$HOME/.dotfiles/nvim-lazy" ]; then
	stow nvim-lazy
	echo -e "  ${GREEN}✓${NC} nvim-lazy stowed"
fi

if [ -d "$HOME/.dotfiles/tmux" ]; then
	stow tmux
	echo -e "  ${GREEN}✓${NC} tmux stowed"
fi

if [ -d "$HOME/.dotfiles/mise" ]; then
	stow mise
	echo -e "  ${GREEN}✓${NC} mise stowed"
fi

if [ -d "$HOME/.dotfiles/bash" ]; then
	# remove omarchy default ~/.bashrc before stow
	if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
		rm "$HOME/.bashrc"
	fi
	stow bash
	echo -e "  ${GREEN}✓${NC} bash stowed"
fi

if [ -d "$HOME/.dotfiles/opencode" ]; then
	stow opencode
	echo -e "  ${GREEN}✓${NC} opencode stowed"
fi

# Install tmux plugin manager
echo ""
echo -e "${YELLOW}Setting up tmux plugin manager...${NC}"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	echo -e "  ${GREEN}✓${NC} TPM installed"
else
	echo -e "  ${GREEN}✓${NC} TPM already installed"
fi

echo ""
echo -e "${GREEN}=== Post-install complete! ===${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Restart your terminal or run: source ~/.bashrc"
echo "  2. Open tmux and press Prefix + I to install tmux plugins"
echo "  3. Configure mise for dotnet and other tools"
