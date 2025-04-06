if not status is-interactive && test "$CI" != true
    exit
end

oh-my-posh init fish --config="$HOME/.config/oh-my-posh/themes/bubblesline-fish.omp.toml" | source

function rerender_on_bind_mode_change --on-variable fish_bind_mode
    if test "$fish_bind_mode" != paste -a "$fish_bind_mode" != "$FISH__BIND_MODE"
        set -gx FISH__BIND_MODE $fish_bind_mode
        omp_repaint_prompt
    end
end

function fish_default_mode_prompt --description "Display vi prompt mode"
    # This function is masked and does nothing
end

function rerender_on_dir_change --on-variable PWD
    omp_repaint_prompt
end
