# Dotfiles

This is a repository for my Linux config files. 
This repository isn't designed for general use as they're specific to my needs/preferences.
However, feel free to copy any bits you like.

### Installing 🖥️   ###
Install by git cloning the repository into your home directory, then running /dotf/install-dotfiles.sh (Read the contents of the script first, you shouldn't just trust random shell scripts you find on the internet!):
```
git clone git://github.com/tamerobots/dotf ~/dotf
cd ~/dotf
./install-dotfiles.sh
```
Restart your terminal, or just enter:
```
source ~/.bashrc
```

install-dotfiles.sh just backs up any relevant dotfiles you may already have in your home directory to a new directory 'dotf_old', and then replaces the originals in the home directory with symlinks to those in /dotf/.

### Cheats 👾  ###

Enter 'cheats' for a cheatlist of commands/functions you can use.

There is also a set of specific cheatsheets for my favourite programs. Access these by entering cheats <program>, for example try 'cheats git'.

You can look in /extras/cheatsheets/ for a list of cheatsheet textfiles you can call in this way.


### Toolscripts ###

There are a few tool scripts I have written in bash for niche purposes. These are in /dotf/extras/toolscripts/

### Thanks ###
Thanks to [github.com/davejamesmiller](https://www.github.com/davejamesmiller), [github.com/michaeljsmalley](https://www.github.com/michaeljsmalley) and others.

