DIR=$(HOME)/dotfiles

all: symlinks brew vim

symlinks:
	@ln -sfh $(DIR)/bin  ~/.bin
	@ln -sfh $(DIR)/colors  ~/.colors
	@ln -sfh $(DIR)/git/gitconfig  ~/.gitconfig
	@ln -sfh $(DIR)/git/gitignore_global  ~/.gitignore_global
	@ln -sfh $(DIR)/nix/profile  ~/.profile
	@ln -sfh $(DIR)/nix/inputrc  ~/.inputrc
	@ln -sfh $(DIR)/ssh  ~/.ssh
	@ln -sfh $(DIR)/tmux  ~/.tmux
	@ln -sfh $(DIR)/tmux/tmux.conf  ~/.tmux.conf
	@ln -sfh $(DIR)/vim  ~/.vim
	@ln -sfh $(DIR)/vimrc  ~/.vimrc
	@ln -sfh $(DIR)/zsh  ~/.zsh
	@ln -sfh $(DIR)/zsh/zshrc  ~/.zshrc
	@ln -sfh $(DIR)/zsh/zprofile  ~/.zprofile

brew:
	$(DIR)/Brewfile

ensure_brew:
	@hash brew &>/dev/null || \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

vim: $(DIR)/vim/bundle/Vundle.vim
	@vim +BundleInstall +:q +:q

%/Vundle.vim:
	@git clone https://github.com/gmarik/Vundle.vim $@


