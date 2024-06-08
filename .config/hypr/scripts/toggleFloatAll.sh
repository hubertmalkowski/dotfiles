#!/bin/zsh


toggleFloat() {
    if [[ $1 == 'float' ]]; then
        hyprctl keyword "windowrulev2 tile, title:^(.*)$"
        hyprctl dispatch -- togglefloating --window title:.*
        echo "tile" >> ./.float-state
    else
        hyprctl keyword "windowrulev2 float, title:^(.*)$"           
        echo "float" >> ./.float-state
    fi

}

if [ -f './.float-state' ]; then
    toggleFloat $(cat ".float-state")
else     
    toggleFloat "tile"
fi
windowrulev2 float, title:^(.*)$
