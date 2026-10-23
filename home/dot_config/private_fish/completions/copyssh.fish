complete -c copyssh -f
complete -c copyssh -a "(path filter -f ~/.ssh/*.pub | path basename)" -d "public key"
complete -c copyssh -a "(path filter -f ~/.ssh/* | path basename | string match -v '*.pub')" -d "ssh file"
