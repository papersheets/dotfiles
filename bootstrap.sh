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

function vimIt() {
    repos=(
        "https://github.com/mileszs/ack.vim.git"
        "https://github.com/scrooloose/nerdtree.git"
        "https://github.com/vim-airline/vim-airline.git"
        "https://github.com/vim-airline/vim-airline-themes.git"
        "https://github.com/altercation/vim-colors-solarized.git"
    )
    root=~/.vim/bundle

    for repo in ${repos[@]}; do
        echo "Checking $repo"
        gitRepo="${repo##*/}"
        directory="${gitRepo%.*}"
        path=$root/$directory
        cloneOrPull $path $repo
    done
}

function cloneOrPull() {
    path=$1
    repo=$2
    if [ ! -d $path ]; then
        echo "No `basename $repo`"
        git clone $repo $path
    else
        git -C $path pull origin master
    fi
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
unset vimIt;
unset cloneOrPull;
