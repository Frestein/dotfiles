status is-interactive; or exit

test "$INSIDE_EMACS" = vterm; or exit

function find_file -d "Switch to a buffer visiting file FILENAME, creating one if none
already exists."
    set -q argv[1]; or set argv[1] "."
    vterm_cmd find-file (realpath "$argv")
end

function say -d "Display a message at the bottom of the screen"
    vterm_cmd message "%s" "$argv"
end

# Completely clear the buffer. With this, everything that is not on screen
# is erased.
function clear
    vterm_printf "51;Evterm-clear-scrollback"
    tput clear
end

function chezmoi_magit_status -d "Show the status of the chezmoi source repository"
    vterm_cmd chezmoi-magit-status
end
