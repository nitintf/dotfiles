# Disable default file completion
complete -c aemu -f

# Provide emulator name completions
function __aemu_list_avds
    emulator -list-avds
end

complete -c aemu -a "(__aemu_list_avds)" -d "Available Android emulators"
