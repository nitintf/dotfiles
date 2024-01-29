#!/bin/bash

# Get the absolute path of the workspace
workspace_path=$(pwd)

# Store the config directory path in a variable
config_path="$HOME/.config"
# Define color codes
RED='\033[0;31m'
NC='\033[0m' # No Color

# Iterate over each item (file or directory) in the workspace
for item in $(find . -maxdepth 1 -type f -or -type d | cut -c 3-); do
    # Get the item name without the trailing slash (if it's a directory)
    item_name=${item%/}
    # Check if a symbolic link with the same name exists in ~/.config
    if [ -L "$config_path/$item_name" ]; then
        # Unlink and delete the symbolic link
        unlink "$config_path/$item_name"
        echo "${RED}Symbolic link for $item_name has been successfully deleted from $config_path.${NC}"
    fi
done
