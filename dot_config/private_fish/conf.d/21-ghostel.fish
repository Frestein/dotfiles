if not status is-interactive && test "$CI" != true
    exit
end

string match -qr '^ghostel(,|$)' -- "$INSIDE_EMACS"; and source "$EMACS_GHOSTEL_PATH/etc/shell/ghostel.fish"
