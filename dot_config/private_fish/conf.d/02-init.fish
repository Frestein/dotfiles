if not status is-interactive && test "$CI" != true
    exit
end

if type -q zoxide
    zoxide init fish | source
end

if type -q atuin
    atuin init fish | source
end

if type -q tv
    tv init fish | source
end

if type -q batpipe
    batpipe | source
end

if type -q direnv
    direnv hook fish | source
end
