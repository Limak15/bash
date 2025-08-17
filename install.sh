#!/usr/bin/env bash

function error() {
    echo -e "\033[1;31m$1\033[0m" >&2
    exit 1
}

function msg() {
    echo -e "$1"
}

function warning() {
    echo -e "\033[1;33m$1\033[0m"
}

function success() {
    echo -e "\033[1;32m$1\033[0m"
}

function yn() {
    local prompt="\033[1m$1\033[0m"
    local answer

    while true; do
        printf "$prompt [Yy Nn]: "
        read -r answer 
        case $answer in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) warning "Please answer yes or no."
        esac
    done
}

function spinner() {
    local pid=$1
    local text=$2
    local delay=0.2
    local spinstr='|/-\'
    while kill -0 "$pid" 2>/dev/null; do
        for i in $(seq 0 3); do
            printf "\r%s %s" "$2" "${spinstr:$i:1}"
            sleep $delay
        done
    done
    wait "$pid"
    local exit_status=$?
    if [ $exit_status -eq 0 ]; then
        printf "\033[1;32m\r%s ✓\033[0m\n" "$text"
    else
        printf "\033[1;31m\r%s ✗\n\033[0m" "$text"
        msg "Check log.txt file for more information"
    fi
    return $exit_status
}




VERSION="v1.0.0"

echo "██████╗  █████╗ ███████╗██╗  ██╗"
echo "██╔══██╗██╔══██╗██╔════╝██║  ██║"
echo "██████╔╝███████║███████╗███████║"
echo "██╔══██╗██╔══██║╚════██║██╔══██║"
echo "██████╔╝██║  ██║███████║██║  ██║"
echo "╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"

echo "$VERSION             Made by Limak"

echo -e "\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

sudo -v

dependencies=("starship" "fastfetch" "wget")

sudo pacman -Sy --noconfirm --needed "${dependencies[@]}" > /dev/null 2> log.txt &
pacman_pid=$!

spinner "$pacman_pid" "Installing dependencies"

wait "$pacman_pid" || exit 1

if [ -f $HOME/.bashrc ]; then
    mv $HOME/.bashrc $HOME/.bashrc.old
fi

ln -s "$(pwd)"/src/bashrc $HOME/.bashrc
ln_pid=$!

spinner "$ln_pid" "Linking bashrc"

wait "$ln_pid" || exit 1

echo -e "\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"

msg "Installation finished"







