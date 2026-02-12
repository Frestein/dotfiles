function swapusage -d 'Show swap usage of processes'
    for arg in $argv
        if test $arg = --help
            echo "\
Usage: swapusage [options]

Options:
  --raw   Show output in KB
  --help  Show this help"
            return 0
        end
    end

    set raw 0
    for arg in $argv
        if test $arg = --raw
            set raw 1
        end
    end

    for file in /proc/*/status
        if test -r $file
            if test $raw -eq 1
                awk '/Name/{name=$2} /VmSwap/{swap_kb=$2} END{printf "%s %d KB\n", name, swap_kb}' $file
            else
                awk '/Name/{name=$2} /VmSwap/{swap_kb=$2} END{printf "%s %.2f MB\n", name, swap_kb/1024}' $file
            end
        end
    end | sort -k 2 -n -r | less
end
