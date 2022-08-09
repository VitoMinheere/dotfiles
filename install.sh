## install basic tools, grouped line by line
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    ssh \
    git \
    curl \
    neovim \
    tmux \
    docker.io \
    google-chrome-stable \
    lua5.1 \
    microsoft-edge-stable \
    gnome-tweaks

## install dotfiles
git clone --bare https://github.com/VitoMinheere/dotfiles.git $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
