#!/bin/bash

mkdir /home/user/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

cp -r /usr/share/hatchery/skel/. /home/user

sed -i "s/USERNAME/user/g" /home/user/.config/gtk-3.0/bookmarks

sed -i '/implicitHeight:\ 120/{n;s/false/true/}' /home/user/.config/quickshell/shell.qml

chown -R user:user /home/user
