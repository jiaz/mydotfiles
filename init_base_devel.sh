#!/bin/bash

# only works in arch based linux
sudo pacman -S --quiet --needed --noconfirm base-devel git tmux vim

# switch to zsh
if [ -z $(echo $SHELL | grep 'zsh') ]; then
	echo "Install zsh..."
	chsh -s `which zsh`

	echo "Configure oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	echo "Clean up zshrc, will be overwritten by my own zshrc"
	rm -f ${HOME}/.zshrc
fi

