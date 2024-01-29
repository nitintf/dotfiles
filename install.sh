#!/bin/bash

# Get the absolute path of the workspace
workspace_path=$(pwd)

# Store the config directory path in a variable
config_path="$HOME/.config"

# Define the array of file or directory names
items=("fish" "kitty" "nvim" "starship" "tmux")

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[1;36m'
NC='\033[0m' # No Color

# Iterate over each item (file or directory) in the workspace
for item_name in "${items[@]}"; do
     # Check if a directory or file with the same name already exists in ~/.config
    if [ -e "$config_path/$item_name" ]; then
        # Check if the existing file is a symbolic link
        if [ -L "$config_path/$item_name" ]; then
            # Check if the symbolic link points to our file
            if [ "$(readlink -- "$config_path/$item_name")" = "$workspace_path/$item_name" ]; then
                echo "${YELLOW}$item_name is already a symbolic link to the correct file. Skipping.${NC}\n"
                continue
            fi
        fi
        # Print the message and ask for confirmation before creating the symbolic link
        echo "\n\nLink ${GREEN}$item_name${NC} in $config_path? (y/n)"
        echo "${YELLOW}already exists. backup will be created.${NC}"
        read -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Creating a backup."
            mv "$config_path/$item_name" "$config_path/${item_name}_backup"
            # Create a symbolic link in ~/.config
            ln -s "$workspace_path/$item_name" "$config_path/$item_name"
            echo "${GREEN}Successfully linked${NC}\n"
        else
            echo "Skipped.\n"
        fi
    else
        # Ask for confirmation before creating the symbolic link
        echo "\n\nLink ${GREEN}$item_name${NC} in $config_path? (y/n)"
        read -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            # Create a symbolic link in ~/.config
            ln -s "$workspace_path/$item_name" "$config_path/$item_name"
            echo "${GREEN}Successfully linked${NC}\n"
        else
            echo "Skipped.\n"
        fi
    fi
done


echo "\n\n\n${GREEN} Dotfiles installation complete! ${NC}\n"
