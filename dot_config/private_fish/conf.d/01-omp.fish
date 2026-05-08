if not status is-interactive && test "$CI" != true
    exit
end

if not type -q oh-my-posh
    exit
end

oh-my-posh init fish --config="$XDG_CONFIG_HOME/oh-my-posh/themes/bubblesline-fish.omp.toml" | source

function rerender_on_bind_mode_change --on-variable fish_bind_mode -d "Trigger oh-my-posh repaint on vi mode change"
    if test "$fish_bind_mode" != paste -a "$fish_bind_mode" != "$FISH__BIND_MODE"
        set -gx FISH__BIND_MODE $fish_bind_mode
        omp_repaint_prompt
    end
end

# INFO: This function is masked and does nothing
function fish_default_mode_prompt -d "Display vi prompt mode"
end

function rerender_on_dir_change --on-variable PWD
    omp_repaint_prompt
end
