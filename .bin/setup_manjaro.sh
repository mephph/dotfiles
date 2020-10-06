#!/usr/bin/env sh

################################################################################
# Install Manjaro and AUR packages
#
# The installed packages list is grepped to check if an AUR package is already
# installed, since `pamac build` doesn't provide a way to check.

PACKAGES=""
PACKAGES_AUR=""

# General desktop use
PACKAGES="$PACKAGES firefox git signal-desktop fzf fd"

# Software development
PACKAGES="$PACKAGES rust python python-pip shellcheck"

if ! pamac list --installed | grep -q neovim-nightly
then
	PACKAGES_AUR="$PACKAGES_AUR neovim-nightly"
fi

# Document preparation
PACKAGES="$PACKAGES pandoc texlive-core biber texlive-science"

# Servers and daemons
PACKAGES="$PACKAGES openssh"

if [ -n "$PACKAGES_AUR" ]
then
	echo "Building packages from AUR."
	# shellcheck disable=SC2086
	pamac build $PACKAGES_AUR
else
	echo "All AUR packages already installed."
fi
echo ""

if [ -n "$PACKAGES" ]
then
	echo "Installing packages from Manjaro repositories."
	# shellcheck disable=SC2086
	pamac install $PACKAGES
fi
echo ""

################################################################################
# Clone dotfiles repository

DOTFILES=$HOME/.dotfiles
if [ -d "$DOTFILES" ]
then
	echo "dotfiles repository already exists in '$DOTFILES'."
else
	echo "dotfiles repository not found. Preparing to clone."

	GITIGNORE=$HOME/.gitignore
	if [ ! -e "$GITIGNORE" ]
	then
		echo ".gitignore not found. Creating it with a .dotfiles entry."
		echo ".dotfiles" >> "$GITIGNORE"
	elif ! grep -q .dotfiles "$GITIGNORE"
	then
		echo "No .dotfiles entry in .gitignore. Adding it."
		echo ".dotfiles" >> "$GITIGNORE"
	else
		echo ".gitignore already contains a .dotfiles entry."
	fi

	echo "Cloning dotfiles repository."
	#git clone --bare git@github.com:mephph/dotfiles.git "$DOTFILES"
fi
echo ""

if [ -e "$HOME/.zsh_aliases" ]
then
	# shellcheck disable=SC1090
	. "$HOME/.zsh_aliases"
fi

################################################################################
# Set up Neovim and plugins

NVIM="$HOME/.config/nvim"
MINPAC="$NVIM/pack/minpac/opt/minpac"
PLUGPAC="$NVIM/autoload/plugpac.vim"

if [ ! -d "$MINPAC" ]
then
	echo "Cloning minpac for neovim."
	git clone https://github.com/k-takata/minpac.git "$MINPAC"
	echo ""
fi

if [ ! -e "$PLUGPAC" ]
then
	echo "Cloning plugpac for neovim."
	curl -fLo "$PLUGPAC" --create-dirs https://raw.githubusercontent.com/bennyyip/plugpac.vim/master/plugpac.vim
	echo ""
fi

if [ -e "$NVIM/init.vim" ] && grep -q "Pack 'k-takata/minpac'" "$NVIM/init.vim"
then
	echo "Found init.vim and plugpac setup command. Running nvim and installing plugins."
	echo "If you get 'E492: Not an editor command: PackInstall' then plugpac plugpac setup is wrong."
	nvim -c :PackInstall
	echo ""
fi
