echo "Creating an SSH key for you..."
ssh-keygen -t rsa

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

echo "Git config"

git config --global user.name "Michael Bianchi"
git config --global user.email michaeldbianchi@gmail.com


echo "Installing brew git utilities..."
brew install legit

echo "Installing other brew stuff..."
brew install wget
# brew install mackup
brew install rbenv
brew install nvm


#@TODO install our custom fonts and stuff

echo "Cleaning up brew"
brew cleanup

echo "Installing homebrew cask"
brew install caskroom/cask/brew-cask

echo "Copying dotfiles from Github"
cd ~
git clone git@github.com:michaeldbianchi/dotfiles.git .dotfiles
cd .dotfiles
sh symdotfiles


echo "Setting ZSH as shell..."
chsh -s /usr/local/bin/zsh

# Apps
apps=(
  spotify
  vagrant
  iterm2
  virtualbox
  onepassword
)

echo "installing apps with Cask..."
brew cask install ${apps[@]}

brew cask alfred link

brew cask cleanup
brew cleanup

echo "Please setup and sync Dropbox, and then run this script again."
read -p "Press [Enter] key after this..."

echo "Restoring setup from Mackup..."
#mackup restore @TODO uncomment


echo "Setting some Mac settings..."
#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Documents"

echo "Done!"
