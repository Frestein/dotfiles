if not status is-interactive && test "$CI" != true
    exit
end

if test "$INSIDE_EMACS" != vterm
    exit
end

alias e="find_file"
alias cz-magit="chezmoi_magit_status"
