#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    echo "Running doIt";
    rsync --exclude ".git/" \
        --exclude "themes/" \
        --exclude ".DS_Store" \
        --exclude ".osx" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        -avh --no-perms . ~;
    source ~/.profile;
    echo "Finished doIt";
}

function vimIt() {
    echo "Running vimIt";
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
    echo "Finished vimIt";
}

function macIt() {
    echo "Running macIt";
    case "$(uname -s)" in
        Darwin*)
            rsync -avh --no-perms .iterm2 ~;
            ;;
    esac
    echo "Finished macIt";
}

function winIt() {
    echo "Running winIt";
    case "$(uname -s)" in
        CYGWIN* | MINGW64*)
            cp themes/SolarizedDark.minttyrc ~/.minttyrc
            ;;
    esac
    echo "Finished winIt";
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
    macIt;
    winIt;
elif [ "$1" == "--light" -o "$1" == "-l" ]; then
    doIt;
    macIt;
    winIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
        vimIt;
        macIt;
        winIt;
    fi;
fi;

unset doIt;
unset vimIt;
unset macIt;
unset winIt;
unset cloneOrPull;
