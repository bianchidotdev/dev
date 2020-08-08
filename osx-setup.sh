#!/usr/bin/env bash

echo "Creating an SSH key for you..."
ssh-keygen -t ed25519 -a 100

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing xcode-stuff"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git
# CLI Tools
formulae=(
  coreutils
  docker
  elixir
  git
  gnupg
  gnutls
  go
  helm
  httpie
  jq
  kubernetes-cli
  legit
  pulumi
  rbenv
  readline
  ruby-build
  sqlite
  tmux
  tmuxinator
  watch
  wget
  zsh
)

echo "Installing other brew stuff..."
brew install ${formulae[@]}


echo "Git config"

git config --global user.name "Michael Bianchi"
git config --global user.email michaeldbianchi@gmail.com


#@TODO install our custom fonts and stuff

echo "Copying dotfiles from Github"
cd ~
git clone git@github.com:michaeldbianchi/dotfiles.git dotfiles
cd dotfiles
sh install.sh


echo "Setting ZSH as shell..."
chsh -s /usr/local/bin/zsh

# Apps
apps=(
  1password
  1password-cli
  brave-browser
  docker
  iterm2
  postman
  spotify
  vagrant
  virtualbox
)

echo "installing apps with Cask..."
brew cask install ${apps[@]}

brew cleanup

echo "Setting some Mac settings..."
#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Documents"

echo "Done!"
