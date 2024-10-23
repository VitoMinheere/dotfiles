# dotfiles
My Linux dotfiles

Read the overview on the [Wiki](https://github.com/VitoMinheere/dotfiles/wiki)

# steps to roll out the dotfiles
- Setup ssh key to be able to also push changes
- Run `git clone --bare https://github.com/VitoMinheere/dotfiles $HOME/.dotfiles`
- Add the alias `alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
- `config checkout`

[Tutorial](https://www.atlassian.com/git/tutorials/dotfiles)
