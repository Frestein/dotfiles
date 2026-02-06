if not status is-interactive && test "$CI" != true
    exit
end

# Piping last command's output
function foot_cmd_start --on-event fish_preexec
    echo -en "\e]133;C\e\\"
end

function foot_cmd_end --on-event fish_postexec
    echo -en "\e]133;D\e\\"
end
