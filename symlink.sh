#!/bin/sh

dir=~/dotfiles
olddir=~/dotfiles_old

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for f in `ls | grep -iv "symlink"`; do
    if [ -a ~/.$f ];
    then
      echo Backing up ~/.$f...
      mv ~/.$f ~/dotfiles_old/
    fi
    rm -f ~/.$f
    echo Symlinking .$f
    ln -s $dir/$f ~/.$f
done

echo "Cleaning up bash_profile awkwardness..."
if [ -a ~/.bash_profile ];
then
  mv ~/.bash_profile $olddir/
fi

echo Done!
