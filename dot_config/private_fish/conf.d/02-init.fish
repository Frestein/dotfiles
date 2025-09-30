if not status is-interactive && test "$CI" != true
    exit
end

zoxide init fish | source

# FIX: fish 4.0 deprecates `bind -k`. transform's Atuin's init to drop -k and ensure up-binding works
if type -q atuin
    set -l __atuin_init (atuin init fish | string replace -ra -- 'bind -M ([^ ]+)\s+-k ' 'bind -M $1 ' | string replace -ra -- 'bind\s+-k ' 'bind ')
    if test -n "$__atuin_init"
        printf '%s\n' $__atuin_init | source
        if functions -q _atuin_bind_up
            bind up _atuin_bind_up
            bind -M insert up _atuin_bind_up
        end
    else
        # fallback: source unmodified but silence deprecation noise
        atuin init fish 2>/dev/null | source
    end
end

# fzf --fish | source
tv init fish | source
batpipe | source
direnv hook fish | source
