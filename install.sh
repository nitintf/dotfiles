#!/bin/bash

# Get the absolute path of the workspace
workspace_path=$(pwd)

# Store the config directory path in a variable
config_path="$HOME/.config"

# List of items to ignore
ignore=("README.md" "install.sh" ".git" ".gitignore")

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Iterate over each item (file or directory) in the workspace
for item in $(find . -maxdepth 1 -type f -or -type d | cut -c 3-); do
    # Get the item name without the trailing slash (if it's a directory)
    item_name=${item%/}

    # Check if the item is in the ignore list
    if printf '%s\n' "${ignore[@]}" | grep -Fxq "$item_name"; then
        continue
    fi

    # Check if a directory or file with the same name already exists in ~/.config
    if [ -e "$config_path/$item_name" ]; then
        # Print the message and ask for confirmation before creating the symbolic link
        echo "\n${YELLOW}$item_name already exists in $config_path. Do you want to create a symlink for $item_name in $config_path and create a backup of the existing item? (y/n) ${NC}\n"
        read -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Creating a backup."
            mv "$config_path/$item_name" "$config_path/${item_name}_backup"
            # Create a symbolic link in ~/.config
            ln -s "$workspace_path/$item_name" "$config_path/$item_name"
            echo "${GREEN}Symbolic link for $item_name has been successfully created in $config_path.${NC}"
        else
            echo "Skipping symbolic link creation for $item_name.\n"
        fi
    else
        # Ask for confirmation before creating the symbolic link
        echo "Do you want to create a symlink for $item_name in $config_path? (y/n) \n"
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
