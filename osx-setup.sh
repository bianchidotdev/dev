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
  bat
  coreutils
  docker
  elixir
  fd
  fzf
  git
  gnupg
  gnutls
  go
  helm
  httpie
  jq
  kubernetes-cli
  legit
  minikube
  pulumi
  rbenv
  readline
  ruby-build
  sqlite
  starship
  terminal-notifier
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
mkdir -p workspace
cd workspace
git clone git@github.com:michaeldbianchi/dev.git
cd dev
sh dotfiles/install.sh


echo "Setting ZSH as shell..."
chsh -s /usr/local/bin/zsh

# Apps
apps=(
  1password
  1password-cli
  bitbar
  brave-browser
  docker
  iterm2
  nordvpn
  postman
  spotify
  tor-browser
  vagrant
  virtualbox
  zoom
)

echo "installing apps with Cask..."
brew cask install ${apps[@]}

echo "installing apps that require manual taps"
brew tap federico-terzi/espanso
brew install espanso
espanso register
read -p "Press [Enter] key after enabling accessibility..."
espanso start

brew cleanup

# Iterm2 setup
ln -s  ~/workspace/dev/dotfiles/iterm-profiles.json '/Library/Application Support/iTerm2/DynamicProfiles/blualism.json'

echo "Setting some Mac settings..."
#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Documents"

echo "Done!"

echo "Still need to install keybase (cask didn't support fs)"
echo "Run `keybase pgp pull-private --all` after installation"
echo "Need to disable adding period after double space"
echo "Install vscode manually since brew cask doesn't handle updates well"
echo "Need to install magnet from apple app store"
