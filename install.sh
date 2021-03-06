#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

for file in bashrc muttrc vim vimrc xsession zshrc XCompose Xmodmap Xresources; do
  test -f ~/.$file || ln -s $BASEDIR/$file ~/.$file
done

test -d ~/.config/awesome        || mkdir -p ~/.config/awesome
test -f ~/.config/awesome/rc.lua || ln -s $BASEDIR/awesome.lua ~/.config/awesome/rc.lua

if [ -x $(which gconftool-2) ]; then
  gconftool-2 --type string --set /apps/gnome_settings_daemon/keybindings/screensaver XF86ScreenSaver
  gconftool-2 --type string --set /apps/gnome_settings_daemon/keybindings/volume_down XF86AudioLowerVolume
  gconftool-2 --type string --set /apps/gnome_settings_daemon/keybindings/volume_up   XF86AudioRaiseVolume
fi
