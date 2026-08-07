if not status is-interactive && test "$CI" != true
    exit
end

set -U __done_exclude '^git (?!push|pull|fetch)' '^bottom' '^yazi' '^nvim' '^emacs' '^emacsclient'
