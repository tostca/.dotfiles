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

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export SHELL="/bin/bash"
if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

export XDG_CONFIG_HOME="$HOME"/.config

complete -C /opt/homebrew/bin/terraform terraform

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/tonystenberg/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
