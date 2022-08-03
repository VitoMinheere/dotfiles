#!/bin/bash
source "$HOME/.config/git-aware.sh"

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.

# Set PS1 for terminals. Displays time, directory and git branch if in git folder
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 6)\]"
BLUE="\[$(tput setaf 4)\]"
WHITE="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"
export PS1="${BOLD}${RED}[${WHITE}\t ${BOLD}${BLUE}\W${RED}]${GREEN}\$git_branch ${WHITE}"

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Save current working dir
touch $HOME/.cwd
PROMPT_COMMAND='pwd > "${HOME}/.cwd" && find_git_branch; history -a'
# Change to saved working dir on load
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)"

# Automatically start and stop ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent > ~/.ssh-agent-thing
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
        eval "$(<~/.ssh-agent-thing)"
fi
alias config='/usr/bin/git --git-dir=/home/bosshogg/.cfg/ --work-tree=/home/bosshogg'
