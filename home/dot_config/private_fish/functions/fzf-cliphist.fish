type -q cliphist; or exit
type -q fzf; or exit

function fzf-cliphist -d 'Show the clipboard history via fzf'
    cliphist list | fzf -d "\t" --with-nth 2 | cliphist decode | wl-copy $argv
end
