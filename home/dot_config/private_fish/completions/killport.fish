# Disable default file completion
complete -c killport -f

# Provide listening port completions, with the owning process as description
function __killport_list_ports
    lsof -nP -iTCP -sTCP:LISTEN | awk 'NR>1 {n=split($9,a,":"); print a[n] "\t" $1}' | sort -un
end

complete -c killport -a "(__killport_list_ports)"
