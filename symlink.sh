#!/bin/bash

dir=~/dotfiles
olddir=~/dotfiles_old

if [ -d $olddir ];
then
  echo Cleaning old backup
  rm -rf $olddir
fi
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for f in `ls | grep -iv "symlink"`; do
    if [ -a ~/.$f ];
    then
      mv ~/.$f ~/dotfiles_old/
    fi
    rm -f ~/.$f
    echo "  Symlinking .$f"
    ln -s $dir/$f ~/.$f
done

# If vundle if not already present, clone
[[ -d $dir/vim/bundle/Vundle.vim ]] || (
  echo Installing vundle...
  git clone https://github.com/gmarik/Vundle.vim $dir/vim/bundle/Vundle.vim
)

echo Done!
