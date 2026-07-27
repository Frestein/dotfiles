if not status is-interactive && test "$CI" != true
    exit
end

if test "$INSIDE_EMACS" != ghostel
    exit
end

function find_file -d "Switch to a buffer visiting file FILENAME, creating one if none already exists"
    set -q argv[1]; or set argv[1] "."
    ghostel_cmd find-file (realpath $argv)
end

alias e=find_file

function dired -d "Open dired"
    set -q argv[1]; or set argv[1] "."
    ghostel_cmd dired (realpath $argv)
end

alias d=dired

function dired-other-window -d "Open dired in other window"
    set -q argv[1]; or set argv[1] "."
    ghostel_cmd dired-other-window (realpath $argv)
end

alias dow=dired-other-window

function magit_status_setup_buffer -d "Show the status of the source repository"
    ghostel_cmd magit-status-setup-buffer (pwd)
end

alias mgs=magit_status_setup_buffer

function magit_status -d "Show the status of the source repository"
    ghostel_cmd magit-status (pwd)
end

alias mgS=magit_status

function chezmoi_magit_status -d "Show the status of the chezmoi source repository"
    ghostel_cmd chezmoi-magit-status
end

alias cz-magit=chezmoi_magit_status

function message -d "Display a message at the bottom of the screen"
    ghostel_cmd message "%s" "$argv"
end

alias say=message
