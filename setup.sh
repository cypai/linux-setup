#!/usr/bin/env bash

CURR_DIR=`pwd`
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

echo "Initializing temp directory..."
if [ -d temp ]; then
    rm -rf temp
fi
mkdir temp

#sudo add-apt-repository ppa:cwchien/gradle
sudo apt update
PACKAGES="git gitk vim xclip python3-pip mc ncdu vlc etckeeper cmake g++ ncftp redshift redshift-gtk geoclue-2.0 htop unrar"
echo "Installing packages: $PACKAGES"
sudo apt install $PACKAGES

if [ "$(grep -c aka ~/.bashrc)" -eq "0" ]; then
    echo "Setting up ~/.bashrc ..."
    cat etc/bashrc_footer >> ~/.bashrc
else
    echo "Skipping setup for ~/.bashrc"
fi

cp etc/gitconfig ~/.gitconfig

if [ -d ~/.bash-git-prompt ]; then
    echo "Skipping setup of bash git prompt"
else
    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
    echo "Please setup bash git prompt themes by running git_prompt_make_custom_theme and editing ~/.git-prompt-colors.sh"
fi

if [ -f ~/.vimrc ]; then
    echo "Skipping install of vim runtime"
else
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cp etc/vimrc ~/.vimrc
    echo "Remember to run :PlugInstall in vim"
fi

cd $CURR_DIR
