if not status is-interactive && test "$CI" != true
    exit
end

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

bind -M insert \cp up-or-search
bind -M visual \cp up-or-search
bind \cp up-or-search

bind -M insert \cn down-or-search
bind -M visual \cn down-or-search
bind \cn down-or-search

bind -M insert \cw forward-bigword
bind -M visual \cw forward-bigword
bind \cw forward-bigword

bind -M insert \x1c forward-char
bind -M visual \x1c forward-char
bind \x1c forward-char
