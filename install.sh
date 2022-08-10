shopt -s expand_aliases

install_packages() {
    ## install basic tools, grouped line by line
    sudo apt update && sudo apt upgrade -y
    ## add neovim ppa to get latest version
    sudo add-apt-repository ppa:neovim-ppa/stable

    sudo apt install -y ssh git curl neovim tmux docker.io lua5.1 gnome-tweaks
}

install_dotfiles() {
    if [ ! -d "$HOME/.dotfiles" ]
    then
        git clone --bare https://github.com/VitoMinheere/dotfiles.git $HOME/.dotfiles
        alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
        config status.showUntrackedFiles no
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

install_edge() {
    sudo apt install apt-transport-https ca-certificates curl software-properties-common wget -y
    sudo wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft-edge.gpg
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | sudo tee /etc/apt/sources.list.d/microsoft-edge.list
    sudo apt update
    sudo apt install microsoft-edge-stable -y
}

install_teams() {
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
    sudo apt update
    sudo apt install teams
}

install_snaps() {
    sudo snap install --classic code
    sudo snap install --classic slack
    sudo snap install zoom-client
}

install_packages
install_dotfiles
adduseranddir
install_edge
install_chrome
install_teams
install_snaps
