function digga --description 'Run `dig` and display the most useful info'
    if test (count $argv) -eq 0
        echo "Usage: digga <domain>"
        return 1
    end
    dig +nocmd $argv[1] any +multiline +noall +answer
end
