DIR=$(HOME)/dotfiles

all: symlinks vim

symlinks:
	@ln -shf $(DIR)/bin  ~/.bin
	@ln -shf $(DIR)/colors  ~/.colors
	@ln -shf $(DIR)/git/gitconfig  ~/.gitconfig
	@ln -shf $(DIR)/git/gitignore_global  ~/.gitignore_global
	@ln -shf $(DIR)/nix/profile  ~/.profile
	@ln -shf $(DIR)/nix/inputrc  ~/.inputrc
	@ln -shf $(DIR)/ssh/config.template  ~/.ssh/config.template
	@ln -shf $(DIR)/tmux  ~/.tmux
	@ln -shf $(DIR)/tmux/tmux.conf  ~/.tmux.conf
	@ln -shf $(DIR)/vim  ~/.vim
	@ln -shf $(DIR)/vimrc  ~/.vimrc
	@ln -shf $(DIR)/zsh  ~/.zsh
	@ln -shf $(DIR)/zsh/zshrc  ~/.zshrc
	@ln -shf $(DIR)/zsh/zprofile  ~/.zprofile
	@ln -shf $(DIR)/autoenv/env ~/.env

brew:
	@$(DIR)/Brewfile

ensure_brew:
	@hash brew &>/dev/null || \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

vim: $(DIR)/vim/autoload/plug.vim
	@vim +PlugInstall +:q +:q

%/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
