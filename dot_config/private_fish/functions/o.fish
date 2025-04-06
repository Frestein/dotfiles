function o --description 'Open a file or directory in the default application'
    if test (count $argv) -eq 0
        xdg-open .
    else
        xdg-open $argv
    end
end

