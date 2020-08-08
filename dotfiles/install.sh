#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# Set the location of the repository on github
repository_location="michaeldbianchi/dotfiles"
repository_branch="master"

dir=${HOME}/.dotfiles                    # dotfiles directory
bckdir=${HOME}/.bck_dotfiles             # old dotfiles backup directory
files="bashrc bash_profile bash_aliases bash_prompt vimrc vim config pryrc psqlrc zshrc zsh_aliases zsh_vars zsh_functions tmux.conf fzf.zsh"    # list of files/folders to symlink in homedir

##########

# Check that git is installed
command -v git > /dev/null 2>&1
if (( $? != 0 )) ; then
    echo Git is required to update dotfiles 1>&2
    exit 1
fi

# Clone dotfiles if they aren't present
if [ ! -d "$dir" ]; then
    # Clone the dotfiles
    echo Cloning remote dotfiles...
    git clone --recursive https://github.com/${repository_location} -b ${repository_branch} ${HOME}/.dotfiles
    git_exit_status=$?
fi

# Pull the most updated copy
cd $dir && git pull
git_exit_status=$?

# If the clone/pull operation failed, exit with the exit status provided by git
if (( $git_exit_status != 0 )) ; then
    echo There was an error while attempting to clone/pull dotfiles! 1>&2
    exit $git_exit_status
fi

# create bck_dotfiles in homedir
echo -n "Creating $bckdir for backup of any existing dotfiles in ~ ..."
mkdir -p $bckdir
echo "done"

# move any existing dotfiles in homedir to bck_dotfiles directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "Moving any existing dotfiles from ~ to $bckdir"
for file in $files; do
		if [ -f ${HOME}/.$file ] || [ -d ${HOME}/.$file ]; then
				echo "Moving .$file to $bckdir/$file"
				mv ${HOME}/.$file $bckdir/$file
		fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ${HOME}/.$file
done

vim +PlugInstall +qall
