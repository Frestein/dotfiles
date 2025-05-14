if status is-interactive
    set -gx SHELL /usr/bin/fish

    set -g fish_key_bindings fish_vi_key_bindings
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore

    function fish_title
        set -q argv[1]; or set argv fish
        # Looks like ~/d/fish: git log
        # or /e/apt: fish
        echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv
    end

    # ------------------------Plugins Options---------------------- #
    # patrickf1/fzf.fish
    set fzf_directory_opts --prompt='  ' --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)" --border-label='Directory' --border-label-pos=-4 --header='Open <C-o>'
    set fzf_git_log_opts --prompt='  ' --border-label='Git Log' --border-label-pos=-4
    set fzf_git_status_opts --prompt='  ' --border-label='Git Status' --border-label-pos=-4
    set fzf_history_opts --prompt='  ' --border-label='Command History' --border-label-pos=-4
    set fzf_processes_opts --prompt='  ' --border-label='Processes' --border-label-pos=-4
    set fzf_variables_opts --prompt='  ' --border-label='Variables' --border-label-pos=-4

    set fzf_preview_dir_cmd eza --all --oneline --color=always --icons=always

    # Use correct fzf-search-history
    # bind \cr _fzf_search_history
    # bind -M insert \cr _fzf_search_history
end
