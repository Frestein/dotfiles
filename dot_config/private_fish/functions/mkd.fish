function mkd --description 'Create a new directory and enter it'
    if test (count $argv) -eq 0
        echo "Usage: mkd <directory>"
        return 1
    end
    mkdir -pv $argv && cd $argv
end
