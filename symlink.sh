#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_old

# Symlink hooks to .git/hooks
if [ ! -L .git/hooks ];
then
  echo Creating hooks symlink...
  rm -rf .git/hooks && ln -s ../hooks ./.git/hooks && echo -e "...done\n"
fi

# If the old backup exists, chuck it out!
if [ -d $olddir ];
then
  echo Cleaning old backup...
  rm -rf $olddir
  echo -e "...done\n"
fi

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo -e "...done\n"

echo -e "Changing to the $dir directory...\n"
cd $dir

# For every file that is not symlink or hooks
for f in `ls | grep -iv -E "hooks|symlink.sh"`; do
    if [ -a ~/.$f ];
    then
      mv ~/.$f ~/dotfiles_old/
    fi
    rm -f ~/.$f
    echo "  Symlinking .$f"
    ln -s $dir/$f ~/.$f
done

echo -e "\n...done\n"

# If vundle if not already present, clone
[[ -d $dir/vim/bundle/Vundle.vim ]] || (
  echo Installing vundle...
  git clone https://github.com/gmarik/Vundle.vim $dir/vim/bundle/Vundle.vim
)

# If tpm is not installed
[[ -d $dir/tmux/plugins/tpm ]] || (
  echo Installing tmux plugin manager...
  git clone https://github.com/tmux-plugins/tpm $dir/tmux/plugins/tpm
)

# Check for nvm
$(hash nvm &>/dev/null) || (

  echo NVM is not present

  echo -n "Would you like to install nvm? [y/n]: " && read yn
  if [ "$yn" = "y" ]; then
    # Possibly out of date. Check https://github.com/creationix/nvm if fails
    curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
    source ~/.bashrc
  fi

  echo -n "Would you like to install node v0.10.X? [y/n]: " && read yn
  if [ "$yn" = "y" ]; then
    nvm install 0.10.x
  fi

)

echo Complete!
