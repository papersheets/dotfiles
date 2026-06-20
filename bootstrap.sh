#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

git pull --ff-only

function doIt() {
    echo "Running doIt";
    rsync --exclude-from=.rsyncignore -avh --no-perms . ~;
    echo "Finished doIt. Reload your shell or run: source ~/.profile";
}

function vimIt() {
    echo "Running vimIt";
    repos=(
        "https://github.com/mileszs/ack.vim.git"
        "https://github.com/scrooloose/nerdtree.git"
        "https://github.com/vim-airline/vim-airline.git"
        "https://github.com/vim-airline/vim-airline-themes.git"
        "https://github.com/altercation/vim-colors-solarized.git"
        "https://github.com/hashivim/vim-terraform.git"
    )
    bundleroot=~/.vim/bundle
    mkdir -p "$bundleroot"

    for repo in "${repos[@]}"; do
        echo "Checking $repo"
        gitRepo="${repo##*/}"
        directory="${gitRepo%.*}"
        path=$bundleroot/$directory
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
    if [ ! -d "$path" ]; then
        echo "No `basename $repo`"
        git clone "$repo" "$path"
    else
        git -C "$path" pull --ff-only
    fi
}

MODE=${1:-}

if [ "$MODE" == "--force" -o "$MODE" == "-f" ]; then
    doIt;
    vimIt;
    macIt;
    winIt;
elif [ "$MODE" == "--light" -o "$MODE" == "-l" ]; then
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
