if not status is-interactive && test "$CI" != true
    exit
end

zoxide init fish | source
fzf --fish | source
atuin init fish | source
batpipe | source
direnv hook fish | source
yt-x completions --fish | source
