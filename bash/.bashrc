source ~/.local/share/omakub/defaults/bash/rc

# Editor used by CLI
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
. "$HOME/.cargo/env"

# export DOTFILES="~/.dotfiles"
# export SCRIPTS="$DOTFILES/scripts"
#
# PATH="${PATH:+${PATH}:}"$SCRIPTS"" # appending

export PATH="$PATH:/home/tony/.dotnet"

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# alias vi=nvim
#
# alias ll='ls -la'
# alias la='ls -lathr'
# alias ls='eza -lh --group-directories-first --icons'
# alias lsa='ls -a'
# alias lt='eza --tree --level=2 --long --icons --git'
# alias lta='lt -a'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='vi $(fp)'

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --bash)"

# GPG config
# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent

# AI tools
# export ANTHROPIC_API_KEY="$(pass personal/ai/claude/api_token)"
# export OPENAI_API_KEY=$(pass personal/openai/rapid_ai_agents_api_token)

# SSH
alias servers="cat ~/.ssh/config | grep \"Host \" | cut -d \" \" -f 2 | grep -v -e \"*\" -e \"personalgit\" -e \"workgit\" -e \"github*\" -e \"gitlab*\" | sort"
alias sshsrv="servers | fzf | xargs -o ssh"

eval "$(starship init bash)"
eval "$(direnv hook bash)"
# eval "$(/usr/bin/mise activate bash)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
