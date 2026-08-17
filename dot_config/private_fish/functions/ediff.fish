function ediff -w emacsclient -d 'Diff two files with Emacs Ediff'
    if test (count $argv) -ne 2
        echo "Usage: ed <file1> <file2>" >&2
        return 1
    end
    emacsclient -t -e "(ediff-files \"$argv[1]\" \"$argv[2]\")"
end
