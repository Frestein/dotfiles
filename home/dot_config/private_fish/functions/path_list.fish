function path_list -d 'Sorted list of directories in PATH'
    echo "$PATH" | tr ":" "\n" | sort $argv
end
