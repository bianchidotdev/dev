#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# Set the location of the repository on github
repository_location="michaeldbianchi/dev"
repository_branch="main"

repo_dir=${HOME}/workspace/dev
dir=${repo_dir}/dotfiles                    # dotfiles directory
bckdir=${HOME}/.bck_dotfiles             # old dotfiles backup directory
files="config doom.d gitignore sh_aliases sh_profile zshrc"    # list of files/folders to symlink in homedir

##########

# Check that git is installed
command -v git > /dev/null 2>&1
if (( $? != 0 )) ; then
  echo Git is required to update dotfiles 1>&2
  exit 1
fi

# Clone dotfiles if they aren't present
if [ ! -d "$repo_dir" ]; then
  # Clone the dotfiles
  echo Cloning remote dotfiles...
  git clone --recursive https://github.com/${repository_location} -b ${repository_branch} $repo_dir
  git_exit_status=$?
fi

# Pull the most updated copy
cd $repo_dir && git pull
git_exit_status=$?

# If the clone/pull operation failed, exit with the exit status provided by git
if (( $git_exit_status != 0 )) ; then
  echo There was an error while attempting to clone/pull dotfiles! 1>&2
  exit $git_exit_status
fi

# create bck_dotfiles in homedir
if [ ! -d "$bckdir" ]; then
  echo -n "Creating $bckdir for backup of any existing dotfiles in ~ ..."
  mkdir -p $bckdir
  echo "done"
fi

# move any existing dotfiles in homedir to bck_dotfiles directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "Moving any existing dotfiles from $HOME to $bckdir"
for file in $files; do
  file_path=$HOME/.$file
  backup_path=$bckdir/$file
  symlink_path=$dir/$file

  if [[ -f $file_path || -d $file_path ]]; then
    if ! readlink $file_path | grep $symlink_path > /dev/null 2>&1; then
      echo "Moving .$file to $backup_path"
      mv $file_path $backup_path
      echo "Creating symlink to $file in home directory."
      ln -sf $symlink_path $file_path
    fi
  else
    echo "Creating symlink to $file in home directory."
    ln -sf $symlink_path $file_path
  fi
done

vim +PlugInstall +qall
