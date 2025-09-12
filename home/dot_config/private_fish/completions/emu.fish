# Disable default file completion
complete -c emu -f

# Provide emulator name completions
function __emu_list_avds
    emulator -list-avds
end

complete -c emu -a "(__emu_list_avds)" -d "Available Android emulators"
