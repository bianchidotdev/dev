#!/usr/bin/env bash

if [[ ! -f $HOME/.ssh/id_ed25519 ]]; then
  echo "Creating an SSH key for you..."
  ssh-keygen -t ed25519 -a 100

  echo "Please add this public key to Github \n"
  cat $HOME/.ssh/id_ed25519.pub
  echo "https://github.com/account/ssh \n"
  read -p "Press [Enter] key after this..."
fi

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

# CLI Tools
formulae=(
  bat
  coreutils
  docker
  elixir
  exa
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
  pinentry-mac
  pulumi
  rbenv
  readline
  ruby-build
  sqlite
  starship
  tealdeer
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
git config --global user.signingkey 792AB06934ACCEB8
git config --global commit.gpgsign true


#@TODO install our custom fonts and stuff

echo "Copying dotfiles from Github"
cd $HOME
mkdir -p workspace
cd workspace
if [[ ! -d ./dev ]]; then
  git clone git@github.com:michaeldbianchi/dev.git
fi
cd dev
sh dotfiles/install.sh


echo "Setting ZSH as shell..."
if [[ ! $(grep "/usr/local/bin/zsh" /etc/shells) ]]; then
  sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
fi

if [[ ! $SHELL = "/usr/local/bin/zsh" ]]; then
  chsh -s /usr/local/bin/zsh
fi

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
if test ! $(which espanso); then
  brew tap federico-terzi/espanso
  brew install espanso
fi
if [[ $(espanso status) != *"running" ]]; then
  espanso register
  read -p "Press [Enter] key after enabling accessibility..."
  espanso start
fi

tldr --update

brew cleanup

# Iterm2 setup
if [[ ! -f "$HOME/Library/Application Support/iTerm2/DynamicProfiles/blualism.json" ]]; then
  mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  ln -s  $HOME/workspace/dev/dotfiles/iterm-profiles.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/blualism.json"
fi

echo "Setting some Mac settings..."
#"Setting screenshots location to $HOME/Desktop"
if [[ $(defaults read com.apple.screencapture location) != "$HOME/Documents" ]]; then
  defaults write com.apple.screencapture location -string "$HOME/Documents"
fi

if test ! $(which keybase); then
  echo "Still need to install keybase (cask didn't support fs)"
  echo "Run 'keybase pgp pull-private --all' after installation"
fi

if test ! $(which code); then
  echo "Install vscode manually since brew cask doesn't handle updates well"
fi

echo "Need to disable adding period after double space"
echo "Need to install magnet from apple app store"
echo "Brave add-ons Eno, 1Password, Pocket, Wikibuy"

echo "Done!"
