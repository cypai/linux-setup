#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Initializing temp directory..."
if [ -d $SCRIPT_DIR/temp ]; then
	rm -rf $SCRIPT_DIR/temp
fi
mkdir $SCRIPT_DIR/temp

PACKAGES="git vim xclip openjdk-8-jdk maven gradle ant python-pip python3-pip vlc"
echo "Installing packages: $PACKAGES"
sudo apt install $PACKAGES

if [ "$(grep -c aka ~/.bashrc)" -eq "0" ]; then
	echo "Setting up ~/.bashrc ..."
	wget -O temp/bashrc_footer https://gist.githubusercontent.com/cypai/d74f5de78fa13f6e20c19fc502691c85/raw/e6a3683da00e44359d70ce82649f3ec45dc4ae7d/.bashrc
	cat temp/bashrc_footer >> ~/.bashrc
	echo "" >> ~/.bashrc
else
	echo "Skipping setup for ~/.bashrc"
fi

if [ -d ~/.bash-git-prompt ]; then
	echo "Skipping setup of bash git prompt"
else
	git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
	echo "Please setup bash git prompt themes by running git_prompt_make_custom_theme and editing ~/.git-prompt-colors.sh"
fi
