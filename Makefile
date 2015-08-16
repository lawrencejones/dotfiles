DIR=$(HOME)/dotfiles

all: symlinks brew vim

symlinks:
	@ln -sf $(DIR)/bin  ~/.bin
	@ln -sf $(DIR)/colors  ~/.colors
	@ln -sf $(DIR)/git/gitconfig  ~/.gitconfig
	@ln -sf $(DIR)/git/gitignore_global  ~/.gitignore_global
	@ln -sf $(DIR)/nix/profile  ~/.profile
	@ln -sf $(DIR)/nix/inputrc  ~/.inputrc
	@ln -sf $(DIR)/ssh/config.template  ~/.ssh/config.template
	@ln -sf $(DIR)/tmux  ~/.tmux
	@ln -sf $(DIR)/tmux/tmux.conf  ~/.tmux.conf
	@ln -sf $(DIR)/vim  ~/.vim
	@ln -sf $(DIR)/vimrc  ~/.vimrc
	@ln -sf $(DIR)/zsh  ~/.zsh
	@ln -sf $(DIR)/zsh/zshrc  ~/.zshrc
	@ln -sf $(DIR)/zsh/zprofile  ~/.zprofile
	@ln -sf $(DIR)/autoenv/env ~/.env

brew:
	@$(DIR)/Brewfile

ensure_brew:
	@hash brew &>/dev/null || \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

vim: $(DIR)/vim/bundle/Vundle.vim
	@vim +BundleInstall +:q +:q

%/Vundle.vim:
	@git clone https://github.com/gmarik/Vundle.vim $@


