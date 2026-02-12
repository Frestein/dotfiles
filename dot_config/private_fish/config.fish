if status is-interactive
    set -gx SHELL /usr/bin/fish

    set -gx LS_COLORS "$(vivid generate gruvbox-dark)"

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

    fish_config theme choose gruvbox-dark

    bind ctrl-s sysz
    bind -M insert ctrl-s sysz
end
