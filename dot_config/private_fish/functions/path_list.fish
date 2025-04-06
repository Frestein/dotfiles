function path_list --description 'Sorted list of directories in PATH'
    echo "$PATH" | tr ":" "\n" | sort $argv
end
