DIR=$(HOME)/dotfiles

all: symlinks ensure_brew brew ruby_env gems node vim

symlinks:
	ln -sfh $(DIR)/bin  ~/.bin
	ln -sfh $(DIR)/colors  ~/.colors
	ln -sfh $(DIR)/git/gitconfig  ~/.gitconfig
	ln -sfh $(DIR)/git/gitignore_global  ~/.gitignore_global
	ln -sfh $(DIR)/nix/inputrc  ~/.inputrc
	ln -sfh $(DIR)/ssh  ~/.ssh
	ln -sfh $(DIR)/tmux  ~/.tmux
	ln -sfh $(DIR)/tmux/tmux.conf  ~/.tmux.conf
	ln -sfh $(DIR)/vim  ~/.vim
	ln -sfh $(DIR)/vimrc  ~/.vimrc
	ln -sfh $(DIR)/zsh  ~/.zsh
	ln -sfh $(DIR)/zsh/zshrc  ~/.zshrc

ensure_brew:
	[ -n "$(which brew)" ] && \
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

