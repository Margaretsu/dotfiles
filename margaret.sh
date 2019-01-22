#!/bin/bash

###
### OPTIONS AND VARIABLES ###
###

while getopts ":a:r:p:h" o; do case "${o}" in
	h) echo -e "Optional arguments for custom use:\\n  -r: Dotfiles repository (local file or url)\\n  -p: Dependencies and programs csv (local file or url)\\n  -a: AUR helper (must have pacman-like syntax)\\n  -h: Show this message" && exit ;;
	r) dotfilesrepo=${OPTARG} && git ls-remote "$dotfilesrepo" || exit ;;
	p) progsfile=${OPTARG} ;;
	a) aurhelper=${OPTARG} ;;
	*) echo "-$OPTARG is not a valid option." && exit ;;
esac done

# DEFAULTS:
[ -z ${dotfilesrepo+x} ] && dotfilesrepo="https://github.com/Margaretsu/voidrice"
[ -z ${progsfile+x} ] && progsfile="https://github.com/Margaretsu/dotfiles/master/margaret.csv"
[ -z ${aurhelper+x} ] && aurhelper="yay"

###
### FUNCTIONS ###
###

initialcheck() { pacman -Syyu --noconfirm --needed dialog || { echo "Are you sure you're running this as the root user? Are you sure you're using an Arch-based distro? ;-) Are you sure you have an internet connection? Are you sure your Arch keyring is updated?"; exit; } ;}

