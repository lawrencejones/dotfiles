DIR=$(HOME)/dotfiles

all: symlinks ensure_brew brew ruby_env gems node vim

symlinks:
	ln -sfh colors  ~/.colors
	ln -sfh git/gitconfig  ~/.gitconfig
	ln -sfh git/gitignore_global  ~/.gitignore_global
	ln -sfh nix/inputrc  ~/.inputrc
	ln -sfh ssh  ~/.ssh
	ln -sfh tmux  ~/.tmux
	ln -sfh tmux/tmux.conf  ~/.tmux.conf
	ln -sfh vim  ~/.vim
	ln -sfh vimrc  ~/.vimrc
	ln -sfh zsh  ~/.zsh
	ln -sfh zsh/zshrc  ~/.zshrc

ensure_brew:
	[ -n "$(which brew)" ] && \
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

