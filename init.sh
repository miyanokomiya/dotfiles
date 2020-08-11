#!/bin/sh

ln -snfv ~/dotfiles/.zshrc ~/.zshrc
ln -snfv ~/dotfiles/.editorconfig ~/.editorconfig

if [ ! -d ~/.cache/dein ]; then
  mkdir -p ~/.cache/dein
  cd ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh  ~/.cache/dein
fi

mkdir -p ~/.cache/dein
ln -snfv ~/dotfiles/dein/.dein.toml ~/.cache/dein/.dein.toml
ln -snfv ~/dotfiles/dein/.dein_lazy.toml ~/.cache/dein/.dein_lazy.toml

mkdir -p ~/.config/nvim
ln -snfv ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -snfv ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json

ln -snfv ~/dotfiles/rplugin ~/.config/nvim
ln -snfv ~/dotfiles/coc-snippets ~/.config/coc/ultisnips

# set up zsh
# $ brew install zsh zsh-completions

# set up neovim
# $ sudo mkdir /usr/local/Frameworks
# $ sudo chown $(whoami):admin /usr/local/Frameworks
# $ brew install python3
# $ pip3 install --upgrade neovim
# $ brew install neovim

# ag
# $ brew install the_silver_searcher

# fzf
# $ brew install fzf
# $ sh /usr/local/opt/fzf/install

# ghq
# $ brew install ghq
git config --global ghq.root ~/ghq

# .gitconfig
git config --global core.editor nvim
git config pull.rebase false
git config --global alias.a "add"
git config --global alias.b "branch"
git config --global alias.c "commit -v"
git config --global alias.co "checkout"
git config --global alias.gr "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.gra "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.l "log"
git config --global alias.lo "log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso"
git config --global alias.pc "pull --rebase origin $(git rev-parse --abbrev-ref HEAD)"
git config --global alias.s "status"
git config --global alias.bc "!f () { git checkout $1; git branch --merged|egrep -v '\*|develop|master'|xargs git branch -d; };f"

# tmux
ln -snfv ~/dotfiles/.tmux.conf ~/.tmux.conf
if [ ! -e ~/.tmux ]; then
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# color theme for iterm
# curl -O https://raw.githubusercontent.com/Arc0re/Iceberg-iTerm2/master/iceberg.itermcolors
