if not status is-interactive && test "$CI" != true
    exit
end

function fzf_bind_multiply
    set multiplier $argv[1]
    set prefix $argv[2]
    set prefixes (for i in (seq $multiplier); echo $prefix; end)
    echo (string join + $prefixes)
end

set preview_down (fzf_bind_multiply 10 'preview-down')
set preview_up (fzf_bind_multiply 10 'preview-up')

set walker_skip "
    GDrive
    Music
    node_modules
    target
    .cache
    .icons
    .local
    .git
    .wine
    .cargo
    .go
    .rye
    .steam
    .cert
    .m2
    .zen
    .java
    .dotnet
    .aspnet
    .gemini
    .simplex
    .telega
    .nuget
    .vcpkg
    .android
    .TranslationPlugin
    .ansible
    .mono
    .mozilla
    .npm
    .ollama
    .pki
    .renpy
    .skiko
    .spotdl
    .supermaven
    .terminfo
    .lgp
    .gradle
    .fleet
    .gnupg
    .cups
    .javacpp
    .lyrics
    .purple
    .stfolder
"

set walker_skip (string split "\n" $walker_skip | string trim | string join ",")

set -gx FZF_CTRL_T_OPTS "
    --bind 'alt-p:toggle-preview'
    --list-border='sharp'
    --border-label='Files'
    --border-label-pos=-4
    --header 'Preview <M-p>'
    --walker-skip $walker_skip
    --preview 'fzf-preview.sh {}'
"
# set -gx FZF_CTRL_R_OPTS "
#     --bind 'alt-y:execute-silent(echo -n {2..} | fish_clipboard_copy)+abort'
#     --list-border='sharp'
#     --border-label='Command History'
#     --border-label-pos=-4
#     --color header:italic
#     --header 'Copy <M-y>'
# "
set -gx FZF_ALT_C_OPTS "
    --bind 'alt-p:toggle-preview'
    --bind 'alt-m:change-multi'
    --list-border='sharp'
	--border-label='Directories'
    --border-label-pos=-4
    --header 'Preview <M-p>  Multi <M-m>'
	--walker-skip $walker_skip
    --preview 'eza -T --color=always --icons {}'
"

# Respect .gitignore
set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

set -gx DISABLE_FZF_AUTO_COMPLETION false
set -gx DISABLE_FZF_KEY_BINDINGS false

set -gx FZF_DEFAULT_OPTS "
    --bind 'ctrl-y:accept'
    --bind 'ctrl-f:$preview_down'
    --bind 'ctrl-b:$preview_up'
    --height 50%
	--border='sharp'
    --border-label=''
    --preview-window='border-sharp'
	--prompt='  '
    --marker='+'
    --pointer=''
    --separator='─'
    --scrollbar='│'
    --color '
        fg:#ebdbb2
        fg+:#fbf1c7
        bg:#282828
        bg+:#3c3836
        gutter:#282828
        hl:#458588
        hl+:#458588
        info:#d79921
        marker:#fb4934
        prompt:#fb4934
        spinner:#b8bb26
        pointer:#b16286
        header:#83a598
        border:#928374
        label:#a89984
        query:#d5c4a1
    '
"

set -gx YT_X_FZF_OPTS "$FZF_DEFAULT_OPTS
    --bind=esc:
"

set -e preview_down preview_up fzf_bind_multiply walker_skip
