if not status is-interactive && test "$CI" != true
    exit
end

# Jumping between prompts
# No configuration is required for fish 4.0+
# Remove this in fish 4.0+
function mark_prompt_start --on-event fish_prompt
    echo -en "\e]133;A\e\\"
end

# Piping last command's output
function foot_cmd_start --on-event fish_preexec
    echo -en "\e]133;C\e\\"
end

function foot_cmd_end --on-event fish_postexec
    echo -en "\e]133;D\e\\"
end
