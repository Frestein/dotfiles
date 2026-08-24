#!/usr/bin/env bash

function fzf_bind_multiply() {
	local multiplier="$1"
	local prefix="$2"
	local result=""

	local i
	for ((i = 1; i <= multiplier; i++)); do
		result+="${prefix}+"
	done

	echo "${result%+}"
}

preview_down=$(fzf_bind_multiply 10 'preview-down')
preview_up=$(fzf_bind_multiply 10 'preview-up')

walker_skip="
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
    .mono
    .mozilla
    .npm
    .ollama
    .pki
    .renpy
    .skiko
    .spotdl
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

walker_skip=$(echo "$walker_skip" | tr '\n' ',' | sed 's/,$//')

export FZF_CTRL_T_OPTS="
    --bind 'alt-p:toggle-preview'
    --list-border='sharp'
    --border-label='Files'
    --border-label-pos=-4
    --header 'Preview <M-p>'
    --color header:italic
    --walker-skip $walker_skip
    --preview 'fzf-preview.sh {}'
"
export FZF_CTRL_R_OPTS="
    --bind 'alt-y:execute-silent(echo -n {2..} | fish_clipboard_copy)+abort'
    --list-border='sharp'
    --border-label='Command History'
    --border-label-pos=-4
    --header 'Copy <M-y>'
    --color header:italic
    --layout=reverse
"
export FZF_ALT_C_OPTS="
    --bind 'alt-p:toggle-preview'
    --bind 'alt-m:change-multi'
    --list-border='sharp'
    --border-label='Directories'
    --border-label-pos=-4
    --header 'Preview <M-p>  Multi <M-m>'
    --color header:italic
    --walker-skip $walker_skip
    --preview 'eza -T --color=always --icons {}'
"

# Respect .gitignore
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export DISABLE_FZF_AUTO_COMPLETION="false"
export DISABLE_FZF_KEY_BINDINGS="false"

export FZF_DEFAULT_OPTS="
    --bind 'ctrl-y:accept'
    --bind 'ctrl-f:$preview_down'
    --bind 'ctrl-b:$preview_up'
    --height 100%
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

unset preview_down preview_up fzf_bind_multiply walker_skip
