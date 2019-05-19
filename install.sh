#!/bin/bash

# find current dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

echo "Current script dir: ${DIR}"

# init software
${DIR}/init_base_devel.sh

# link current folder to $HOME/.dotfiles
echo "Resolving \$HOME as ${HOME}..."
echo "Linking current folder to ${HOME}/.dotfiles"

if [ -e ${HOME}/.dotfiles ]; then
	if [ -L ${HOME}/.dotfiles ]; then
		echo "Remove the existing link"
		rm -f ${HOME}/.dotfiles
	else
		echo "Cannot determine how to deal with the existing dotfiles folder. Exit"
		exit 1
	fi
fi

ln -s ${DIR} ${HOME}/.dotfiles

# initiate .zshrc
echo "Linking zshrc"
ln -sf ${HOME}/.dotfiles/zshrc ${HOME}/.zshrc

# initiate alias
echo "Linking alias"
ln -sf ${HOME}/.dotfiles/alias ${HOME}/.alias

# initiate functions
echo "Linking functions"
ln -sf ${HOME}/.dotfiles/functions ${HOME}/.functions

# initiate env vars
echo "Linking env vars"
ln -sf ${HOME}/.dotfiles/envs ${HOME}/.envs

# initiate gitconfig 
echo "Linking gitconfig"
ln -sf ${HOME}/.dotfiles/gitconfig ${HOME}/.gitconfig

echo "Please login again to ensure all settings are effective"
