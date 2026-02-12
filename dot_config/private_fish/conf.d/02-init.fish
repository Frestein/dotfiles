if not status is-interactive && test "$CI" != true
    exit
end

zoxide init fish | source
atuin init fish | source
tv init fish | source
batpipe | source
direnv hook fish | source
