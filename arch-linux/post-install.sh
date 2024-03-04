#!/bin/sh

# Update all packages
pacman -Syu --noconfirm

# Packages for development
pacman -S --noconfirm git \
	stow \
	neovim \
	vim \
	fd \
	lazygit \
	docker \
	tmux \
	qmk \
	deno \
	ttf-nerd-fonts-symbols-mono \
	ttf-jetbrains-mono-nerd \
	ttf-victor-mono-nerd \
	fzf \
	coreutils \
	curl \
	wget \
	bat \
	autoconf \
	openssl \
	libxslt \
	fop \
	go \
	go-tools \
	sqlite \
	jq \
	yq \
	ripgrep \
	rofi \
	dash \
	imlib2 \
	xorg-xsetroot \
	feh \
	acpi \
	libx11 \
	libxft \
	libxinerama \
	freetype2 \
	fontconfig \
	picom \
	ncurses \
	glu \
	mesa \
	wxwidgets-gtk3 \
	libpng \
	libssh \
	unzip \
	rust
