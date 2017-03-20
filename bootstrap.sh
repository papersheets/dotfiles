#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    rsync --exclude ".git/" \
        --exclude "themes/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude "bootstrap.sh" \
        -avh --no-perms . ~;
    source ~/.profile;
}

function cloneOrPull() {
    path=$1
    repo=$2
    if [ ! -d $path ]; then
        echo "No `basename $repo`"
        git clone $repo $path
    else
        git -C $path pull
    fi
}

function vimIt() {
    root=~/.vim/bundle
    path=$root/ack.vim
    cloneOrPull $path https://github.com/mileszs/ack.vim.git
    path=$root/nerdtree
    cloneOrPull $path https://github.com/scrooloose/nerdtree.git
    path=$root/vim-airline
    cloneOrPull $path https://github.com/vim-airline/vim-airline
    path=$root/vim-airline-themes
    cloneOrPull $path https://github.com/vim-airline/vim-airline-themes
    path=$root/vim-colors-solarized
    cloneOrPull $path https://github.com/altercation/vim-colors-solarized.git
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
    vimIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
        vimIt;
    fi;
fi;
unset doIt;
