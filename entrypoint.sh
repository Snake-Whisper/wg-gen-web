#!/bin/ash

if [ -d /ui ]; then
    cd  /ui
    set ./* ./.[!.]* ./..?*
    if   [ -n "$4" ] ||
        for e do 
            [ -L "$e" ] ||
            [ -e "$e" ] && break
        done
    then ! echo "/ui not empty -> assuming ui files already copied :)"
    else
        echo -n "copy ui files... "
        cp -r /app/ui/dist/* /ui
        echo "[ ok ]"
    fi
    cd /app
else
    echo Please add volume to /ui to access ui bundle
fi
sudo -u wgui /app/wg-gen-web-linux