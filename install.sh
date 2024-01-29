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

ARROW='➜'
TICK='✔'
WRONG='✖'

# Iterate over each item (file or directory) in the workspace
for item_name in "${items[@]}"; do
     # Check if a directory or file with the same name already exists in ~/.config
    if [ -e "$config_path/$item_name" ]; then
        # Print the message and ask for confirmation before creating the symbolic link
        echo "\n\nDo you want to create a symlink for ${GREEN}$item_name${NC} in $config_path? (y/n)"
        echo "${YELLOW}$item_name already exists in $config_path. backup will be created.${NC}"
        read -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Creating a backup."
            mv "$config_path/$item_name" "$config_path/${item_name}_backup"
            # Create a symbolic link in ~/.config
            ln -s "$workspace_path/$item_name" "$config_path/$item_name"
            echo "Symbolic link for ${GREEN}$item_name${NC} has been successfully created in $config_path."
        else
            echo "Skipping symbolic link creation for $item_name.\n"
        fi
    else
        # Ask for confirmation before creating the symbolic link
        echo "\nDo you want to create a symlink for ${GREEN}$item_name${NC} in $config_path? (y/n)"
        read -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            # Create a symbolic link in ~/.config
            ln -s "$workspace_path/$item_name" "$config_path/$item_name"
            echo "${GREEN}Symbolic link for $item_name has been successfully created in $config_path.${NC}\n"
        else
            echo "Skipping symbolic link creation for $item_name.\n"
        fi
    fi
done


echo "\n${GREEN} Dotfiles installation complete! ${NC}\n"
