function fzf-cliphist --description 'Show the clipboard history via fzf'
    cliphist list | fzf -d "\t" --with-nth 2 | cliphist decode | wl-copy $argv
end
