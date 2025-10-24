if not status is-interactive && test "$CI" != true
    exit
end

zoxide init fish | source

# FIX: fish 4.0 deprecates `bind -k`. transform's Atuin's init to drop -k and ensure up-binding works
# https://github.com/atuinsh/atuin/issues/2803, https://github.com/atuinsh/atuin/issues/2940
atuin init fish | sed "s/-k up/up/g" | source

# fzf --fish | source
tv init fish | source
batpipe | source
direnv hook fish | source
