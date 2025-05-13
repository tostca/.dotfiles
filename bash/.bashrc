#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# config
export BROWSER="firefox"

# directories
export DOTFILES="~/.dotfiles"
export SCRIPTS="$DOTFILES/scripts"

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~
# function from Arch Wiki, to prevent adding directories multiple times

# set_path(){
#
#     # Check if user id is 1000 or higher
#     [ "$(id -u)" -ge 1000 ] || return
#
#     for i in "$@";
#     do
#         # Check if the directory exists
#         [ -d "$i" ] || continue
#
#         # Check if it is not already in your $PATH.
#         echo "$PATH" | grep -Eq "(^|:)$i(:|$)" && continue
#
#         # Then append it to $PATH and export it
#         export PATH="${PATH}:$i"
#     done
# }
#
# set_path "$HOME"/git/lab/bash "$HOME"/.local/bin

# https://unix.stackexchange.com/questions/26047/how-to-correctly-add-a-path-to-path
# PATH="${PATH:+${PATH}:}~/opt/bin"   # appending
# PATH="~/opt/bin${PATH:+:${PATH}}"   # prepending

PATH="${PATH:+${PATH}:}"$SCRIPTS"" # appending
# PATH="${PATH:+${PATH}:}"$SCRIPTS":/opt/homebrew/opt/dotnet@6/bin:/opt/homebrew/opt/dotnet/bin:"$HOME"/.local/bin:"$HOME"/.dotnet/tools" # appending

export PATH="$PATH"
# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# AWS SSO Default settings
export AWS_DEFAULT_SSO_START_URL=https://onceupon.awsapps.com/start
export AWS_DEFAULT_SSO_REGION=eu-central-1

# Elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

# if ! pgrep -u "$USER" ssh-agent >/dev/null; then
# 	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
# 	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
function parse_git_dirty {
  [[ $(git status --porcelain 2>/dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

# export PS1="\n\t \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n> "
export PS1="\n \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n> "

alias vi=nvim

alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias c="clear"

# ls
# alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'
alias ls='eza -lh --group-directories-first --icons'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# alias sv='sudoedit'
# alias sk='killall ssh-agent && source ~/.zshrc'
alias t='tmux'
# alias e='exit'
alias syu='sudo pacman -Syu'

# git
# alias gp='git pull'
# alias gpr='git pull --rebase'
# alias gs='git status'
alias lg='lazygit'

alias sz='source ~/.zshrc'
alias sbr='source ~/.bashrc'

# vim & second brain
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0-inbox/"

# env variables
export VISUAL=nvim
export EDITOR=nvim

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# start virt-manager
# alias virt='virt-manager -c "qemu:///session" --no-fork'

# sourcing
# source "$HOME/.privaterc"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# GPG config
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# AI tools
# export ANTHROPIC_API_KEY="$(pass personal/ai/claude/api_token)"
# export OPENAI_API_KEY=$(pass personal/openai/rapid_ai_agents_api_token)

# SSH
alias servers="cat ~/.ssh/config | grep \"Host \" | cut -d \" \" -f 2 | grep -v -e \"*\" -e \"personalgit\" -e \"workgit\" -e \"github*\" -e \"gitlab*\" | sort"
alias sshsrv="servers | fzf | xargs -o ssh"

eval "$(starship init bash)"
eval "$(direnv hook bash)"
eval "$(/usr/bin/mise activate bash)"
