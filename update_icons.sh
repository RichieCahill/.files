#!/bin/bash

rm -rf ~/.icons/candy-icons
rm -rf ~/.themes/Sweet-nova

git clone https://github.com/EliverLara/candy-icons.git ~/.icons/candy-icons
git clone -b nova https://github.com/EliverLara/Sweet.git ~/.themes/Sweet-nova

gtk-update-icon-cache ~/.icons/candy-icons 
gsettings set org.gnome.desktop.interface gtk-theme "Sweet-nova"
gsettings set org.gnome.desktop.wm.preferences theme "Sweet-nova"
