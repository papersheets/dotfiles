# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# set PATH to include coreutils on mac
if [ -d "/usr/local/opt/coreutils/libexec/gnubin" ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# set PATH to include homebrew sbin on mac
if [ -d "/usr/local/sbin" ]; then
    PATH="/usr/local/sbin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
