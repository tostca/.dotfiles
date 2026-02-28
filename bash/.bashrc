# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
#
# Use VSCode instead of neovim as your default editor
# export EDITOR="code"
#
# Set a custom prompt with the directory revealed (alternatively use https://starship.rs)
# PS1="\W \[\e]0;\w\a\]$PS1"

# PATH="${PATH:+${PATH}:}"$SCRIPTS"" # appending
export PATH="$PATH:/home/tony/.dotnet"

# dotnet global tools
export PATH="$PATH:/home/tony/.dotnet/tools"

# Enable to run Elixir escripts as executables
export PATH="$PATH:/home/tony/.mix/escripts"

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# opencode cli
export OPENCODE_EXPERIMENTAL_LSP_TOOL=true

# SSH
alias servers="cat ~/.ssh/config | grep \"Host \" | cut -d \" \" -f 2 | grep -v -e \"*\" -e \"personalgit\" -e \"workgit\" -e \"github*\" -e \"gitlab*\" | sort"
alias sshsrv="servers | fzf | xargs -o ssh"
export SSH_AUTH_SOCK=~/.1password/agent.sock

eval "$(starship init bash)"
eval "$(direnv hook bash)"
