function set_nvm --on-event fish_prompt
    # Avoid running if directory didn't change
    string match -q $PWD $PREV_PWD; and return

    # Remember current directory
    set -g PREV_PWD $PWD

    # Check if .nvmrc file exists and run nvm use
    if test -e .nvmrc
        nvm use
        set NVM_DIRTY true
    else if test "$NVM_DIRTY" = true
        # Revert to default node version when leaving a directory with .nvmrc
        nvm use default
        set NVM_DIRTY false
    end
end
