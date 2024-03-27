#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

# Set to superior editing mode
set -o vi

# keybinds
# bind -x '"\C-l":clear'
# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

# config
export BROWSER="firefox"

# directories
# export REPOS="$HOME/Repos"
# export GITUSER="mischavandenburg"
# export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="~/.dotfiles"
# export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export ICLOUD="$HOME/icloud"
export SECOND_BRAIN="$HOME/second-brain"

# Go related. In general all executables and scripts go in .local/bin
# export GOBIN="$HOME/.local/bin"
# export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
# export GOPATH="$HOME/.local/share/go"
# export GOPATH="$HOME/go/"

# dotnet
# export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"

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

# Commands also provided by macOS and the commands dir, dircolors, vdir have been installed with the prefix "g".
# If you need to use these commands with their normal names, you can add a "gnubin" directory to your PATH with:
#  PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

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

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# This function is stolen from rwxrob

# clone() {
# 	local repo="$1" user
# 	local repo="${repo#https://github.com/}"
# 	local repo="${repo#git@github.com:}"
# 	if [[ $repo =~ / ]]; then
# 		user="${repo%%/*}"
# 	else
# 		user="$GITUSER"
# 		[[ -z "$user" ]] && user="$USER"
# 	fi
# 	local name="${repo##*/}"
# 	local userd="$REPOS/github.com/$user"
# 	local path="$userd/$name"
# 	[[ -d "$path" ]] && cd "$path" && return
# 	mkdir -p "$userd"
# 	cd "$userd"
# 	echo gh repo clone "$user/$name" -- --recurse-submodule
# 	gh repo clone "$user/$name" -- --recurse-submodule
# 	cd "$name"
# } && export -f clone

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki

# if ! pgrep -u "$USER" ssh-agent >/dev/null; then
# 	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
# 	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# Only run on Ubuntu

# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	eval "$(ssh-agent -s)" >/dev/null
# fi

# adding keys was buggy, add them outside of the script for now
# ssh-add -q ~/.ssh/mischa
# ssh-add -q ~/.ssh/mburg
#{
# ssh-add -q ~/.ssh/id_ed25519
# ssh-add -q ~/.ssh/vanoord
#} &>/dev/null

# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~
function parse_git_dirty {
	[[ $(git status --porcelain 2>/dev/null) ]] && echo "*"
}
function parse_git_branch {
	git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

# export PS1="\n\t \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n> "
export PS1="\n \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n> "

# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
# export GIT_PS1_SHOWCOLORHINTS=1
# export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWUPSTREAM="auto git"

# if [[ -f "$XDG_CONFIG_HOME/bash/gitprompt.sh" ]]; then
# 	source "$XDG_CONFIG_HOME/bash/gitprompt.sh"
# fi

# PROMPT_COMMAND='__git_ps1 "\u@\h:\W" " \n$ "'
# colorized prompt
# PROMPT_COMMAND='__git_ps1 "\[\e[33m\]\u\[\e[0m\]@\[\e[34m\]\h\[\e[0m\]:\[\e[35m\]\W\[\e[0m\]" " \n$ "'

# The __git_ps1 function prompt is provided by the bash completion installed by brew. See https://github.com/mischavandenburg/dotfiles/issues/5

# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~

alias v=nvim
# alias vim=nvim

# cd
# alias vo='cd $REPOS/github.com/VanOord/'
alias ..="cd .."
alias scripts='cd $SCRIPTS'
alias cdblog="cd ~/personal/blog"
alias cdpblog='cd $SECOND_BRAIN/2-areas/blog/content'
# alias lab='cd $LAB'
# alias alab='cd $GHREPOS/azure-lab'
alias dot='cd $GHREPOS/dotfiles'
# alias repos='cd $REPOS'
# alias cdgo='cd $GHREPOS/go/'
# alias ex='cd $REPOS/github.com/mischavandenburg/go/Exercism/'
# alias rwdot='cd $REPOS/github.com/rwxrob/dot'
alias c="clear"
alias icloud="cd \$ICLOUD"
# alias rob='cd $REPOS/github.com/rwxrob'
# alias homelab='cd $REPOS/github.com/mischavandenburg/homelab/'
# alias hl='homelab'
# alias hlp='cd $REPOS/github.com/mischavandenburg/homelab-private/'
# alias hlps='cd $REPOS/github.com/mischavandenburg/homelab-private-staging/'
# alias hlpp='cd $REPOS/github.com/mischavandenburg/homelab-private-production/'

# ls
alias ls='ls --color=auto'
alias ll='ls -la'
# alias la='exa -laghm@ --all --icons --git --color=always'
alias la='ls -lathr'

# finds all files recursively and sorts by last modification, ignore hidden files
alias last='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias sv='sudoedit'
alias sk='killall ssh-agent && source ~/.zshrc'
alias t='tmux'
alias e='exit'
alias syu='sudo pacman -Syu'

# git
alias gp='git pull'
alias gpr='git pull --rebase'
alias gs='git status'
alias lg='lazygit'

# ricing
# alias et='v ~/.config/awesome/themes/powerarrow/theme-personal.lua'
# alias ett='v ~/.config/awesome/themes/powerarrow-dark/theme-personal.lua'
# alias er='v ~/.config/awesome/rc.lua'
# alias ez='v ~/.zshrc'
# alias eb='v ~/.bashrc'
# alias ev='cd ~/.config/nvim/ && v init.lua'
alias sz='source ~/.zshrc'
alias sbr='source ~/.bashrc'
# alias s='startx'

# vim & second brain
alias sb="cd \$SECOND_BRAIN"
alias in="cd \$SECOND_BRAIN/0-inbox/"
# alias vbn='python ~/git/python/brainfile.py'

# starting programmes
# alias cards='python3 /opt/homebrew/lib/python3.11/site-packages/mtg_proxy_printer/'

# terraform
# alias tp='terraform plan'

# fun
# alias fishies=asciiquarium

# kubectl
# alias k='kubectl'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k
# alias kgp='kubectl get pods'
# alias kc='kubectx'
# alias kn='kubens'
#
# alias kcs='kubectl config use-context admin@homelab-staging'
# alias kcp='kubectl config use-context admin@homelab-production'

# env variables
export VISUAL=nvim
export EDITOR=nvim

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='v $(fp)'

# start virt-manager
alias virt='virt-manager -c "qemu:///session" --no-fork'

# sourcing
# source "$HOME/.privaterc"

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "$HOME/.fzf.bash"
	# echo "I'm on Mac!"

	# brew bash completion
	[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
	#	source /usr/share/fzf/key-bindings.bash
	#	source /usr/share/fzf/completion.bash
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/tonystenberg/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# ASDF version control
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
#
# if command -v pyenv 1>/dev/null 2>&1; then
# 	eval "$(pyenv init -)"
# fi

# alias pip=/usr/local/bin/pip3
# alias python=$(which python3)

# dotnet
export PATH="$HOME/.dotnet:$PATH"

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export PATH=$JAVA_HOME/bin:$PATH

# trying to deal with an OOM heap error in LSP server
export GRADLE_OPTS="-Xmx12g -XX:+UseParallelGC"
export JAVA_OPTS="-Xmx12g -XX:+UseParallelGC"
# export _JAVA_OPTIONS="-Xmx12g -XX:+UseParallelGC -Dkotlin.daemon.jvm.options=-Xmx6g -XX:MaxMetaspaceSize=6g -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8"
export JDK_JAVA_OPTIONS="-Xmx12g -XX:+UseParallelGC"

# Created by `pipx` on 2021-11-29 13:02:51
export PATH="$PATH:/Users/tonystenberg/.local/bin"

# GPG config
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# work gitlab
export GITLAB_BASE_URL=$(pass work/gitlab/terraform/base_url)
export GITLAB_ACCESS_TOKEN="$(pass work/gitlab/terraform/init)"
export GITLAB_TOKEN="$(pass work/gitlab/terraform/init)"
