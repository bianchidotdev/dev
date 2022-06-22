#!/usr/bin/env bash

repo_dir=$HOME/workspace/dev
source $repo_dir/dotfiles/sh_profile
notifier=terminal-notifier

function log {
  echo ""
  echo "$timestamp ----- $1 -----"
}

function timestamp {
  date +"%Y-%m-%dT%H:%M:%S"
}

function notify {
  echo "OSX Setup Script Broken - Notifying with $notifier"
  >&2 echo "$1"
  $notifier \
    -title "OSX Setup Script Broken!" \
    -message "$1" \
    -activate com.google.code.iterm2
}


log "Starting OSX Setup Script"

if [[ $(xcode-select -p 1>/dev/null) ]]; then
  log "Installing xcode-stuff"
  xcode_err=`xcode-select --install 2>&1`
  if [ $? -ne 0 ]; then
    notify "$xcode_err"
    exit 1;
  fi 
fi

log "Copying down dev directory"
cd $HOME
mkdir -p workspace
cd workspace
if [[ ! -d ./dev ]]; then
  echo "Copying dotfiles from Github"
  git clone git@github.com:michaeldbianchi/dev.git
else
  cd dev
  git pull
fi

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  log "Installing homebrew..."
  brew_err=`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)" 2>&1`
  if [ $? -ne 0 ]; then
    notify "$brew_err"
    exit 1;
  fi 
fi

if test ! $(which rustup); then
  log "Installing rustup..."
  rustup_err=`"curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
 2>&1`
  if [ $? -ne 0 ]; then
    notify "$rustup_err"
    exit 1;
  fi 
fi

if test ! $(which cargo); then
  log "Installing rust..."
  rust_err=`"rustup install stable" 2>&1`
  if [ $? -ne 0 ]; then
    notify "$rust_err"
    exit 1;
  fi 
fi

# Update homebrew recipes
log "Updating homebrew"

brew_err=`brew update 2>&1`
if [ $? -ne 0 ]; then
  notify "$brew_err"
  exit 1;
fi 

# bat
# exa
# fd
# starship
# tealdeer

# CLI Tools
formulae=(
  asdf
  # docker
  fzf
  git
  google-cloud-sdk
  gnupg
  gnutls
  jq
  keybase
  kubernetes-cli
  minikube
  ngrok
  pinentry-mac
  pritunl
  rbenv
  readline
  ruby-build
  terminal-notifier
  tmux
  wget
  zsh
)

# bc for some reason brew list takes close to a full second
installed=$(brew list --formula)

log "Installing brew formulae"
for i in "${formulae[@]}"; do
  if ! echo $installed | grep "$i" > /dev/null; then
    brew_err=`brew install --formula $i 2>&1`
    if [ $? -ne 0 ]; then
      notify "$brew_err"
      exit 1;
    fi 
  fi
done

log "Configuring git"

if test ! $(git config --global --get pull.rebase); then
  git config --global pull.rebase false
fi

if test ! $(git config --global --get user.name > /dev/null); then
  git config --global user.name "Michael Bianchi"
fi

if test ! $(git config --global --get user.email); then
  git config --global user.email michaeldbianchi@gmail.com
fi

# 1password
# 1password-cli
# brave-browser
# spotify
# tor-browser
# virtualbox
# zoom
if test ! $(git config --global --get core.excludesfile); then
  git config --global core.excludesfile ~/.gitignore
fi

# Apps
apps=(
  vagrant
)

installed_casks=$(brew list --casks)

log "Installing brew casks"
for i in "${apps[@]}"; do
  if ! echo $installed_casks | grep "$i" > /dev/null; then
    brew install --cask $i
  fi
done

log "Updating tldr"
tldr --update

log "Cleaning up brew"
brew cleanup

# Iterm2 setup
if [[ ! -f "$HOME/Library/Application Support/iTerm2/DynamicProfiles/blualism.json" ]]; then
  log "Configuring iterm2 dynamic profile"
  mkdir -p "$HOME/Library/Application Support/iTerm2/DynamicProfiles"
  ln -s  $repo_dir/dotfiles/iterm-profiles.json "$HOME/Library/Application Support/iTerm2/DynamicProfiles/blualism.json"
fi

log "Setting OSX settings"
#"Setting screenshots location to $HOME/Desktop"
if [[ $(defaults read com.apple.screencapture location) != "$HOME/Documents" ]]; then
  defaults write com.apple.screencapture location -string "$HOME/Documents"
fi

#@TODO install our custom fonts and stuff

# Interactive shell only
if [ "`tty`" != "not a tty" ]; then
  log "Interactive Shell Section"

  if [[ ! -f $HOME/.ssh/id_ed25519 ]]; then
    log "Creating an SSH key ..."
    ssh-keygen -t ed25519 -a 100

    echo "Please add this public key to Github \n"
    cat $HOME/.ssh/id_ed25519.pub
    echo "https://github.com/account/ssh \n"
    read -p "Press [Enter] key after this..."
  fi

  log "Installing dotfiles"
  cd $HOME/workspace/dev
  sh dotfiles/install.sh
  echo "Successfully installed dotfiles"

  log "Setting up zsh"
  if [[ ! $(grep "/usr/local/bin/zsh" /etc/shells) ]]; then
    echo "Setting ZSH as shell..."
    sudo bash -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
  fi

  if [[ ! $SHELL = "/usr/local/bin/zsh" ]]; then
    chsh -s /usr/local/bin/zsh
  fi

  log "Configuring cron"
  (crontab -l ; cat $repo_dir/control/crontab) | sort - | uniq - | crontab -
fi


echo ""
echo "Done!"

log "Manual Steps"
if test ! $(which keybase); then
  echo "Still need to install keybase (cask didn't support fs)"
  echo "Run 'keybase pgp pull-private --all' after installation"
fi

if test ! $(which code); then
  echo "Install vscode manually since brew cask doesn't handle updates well"
fi

if [[ $(fd 'nord.*\.app$' /Applications/ | wc -l) -lt 1 ]]; then
  echo 'Install Nord VPN manually via App Store'
fi

echo "Need to install slack manually for easier updates"
echo "Need to disable adding period after double space"
echo "Need to install magnet from apple app store"
echo "Brave add-ons Eno, 1Password, Pocket, Wikibuy"

