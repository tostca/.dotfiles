# This is taken from Mischa Vandenburg
# https://github.com/mischavandenburg/dotfiles/blob/main/.bash_profile

# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
	# needed for brew
	export BASH_SILENCE_DEPRECATION_WARNING=1
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Only run these on Ubuntu

# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	# needed for brew to work
# 	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# fi

export SHELL="/bin/bash"
if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

export XDG_CONFIG_HOME="$HOME"/.config
