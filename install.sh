shopt -s expand_aliases

install_packages() {
    ## install basic tools, grouped line by line
    sudo apt update && sudo apt upgrade -y
    ## add neovim ppa to get latest version
    sudo add-apt-repository ppa:neovim-ppa/stable

    sudo apt install -y ssh git curl neovim tmux tmuxinator docker.io lua5.1 gnome-tweaks
    sudo apt install -y python3-pip python3-venv python3-tk
}

install_dotfiles() {
    if [ ! -d "$HOME/.dotfiles" ]
    then
        git clone --bare https://github.com/VitoMinheere/dotfiles.git $HOME/.dotfiles
        alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
        config config status.showUntrackedFiles no
        config checkout
        config remote set-url origin git@github.com:VitoMinheere/dotfiles.git
    else
        echo "dotfiles already installed"
    fi
}

adduseranddir() { \
	# Adds user `$name` with password $pass1.
	dialog --infobox "Adding user \"$USER\"..." 4 50
    groupadd -f docker
	useradd -m --G docker -s /bin/bash "$USER" >/dev/null 2>&1 ||
    mkdir -p /home/"$USER"/Developer
}

install_chrome() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
}

install_snaps() {
    sudo snap install --classic code
}

install_packages
install_dotfiles
adduseranddir
install_chrome
install_snaps
