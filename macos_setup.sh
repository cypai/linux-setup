#!/usr/bin/env bash

CURR_DIR=`pwd`
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPT_DIR

echo "Initializing temp directory..."
if [ -d temp ]; then
    rm -rf temp
fi
mkdir temp

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew cask install java
brew install git maven gradle ant wget pyenv direnv fzf
brew cask install vlc

cat <<EOF > ~/.bash_profile
if [ -r ~/.bashrc ]; then
    source ~/.bashrc
fi
EOF
if [ -r ~/.bashrc ]; then
    echo "Skipping setup for ~/.bashrc"
else
    echo "Setting up ~/.bashrc ..."
    cp etc/macos_bashrc ~/.bashrc
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
