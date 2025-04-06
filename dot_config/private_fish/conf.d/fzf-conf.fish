if not status is-interactive && test "$CI" != true
    exit
end

function fzf_bind_multiply
    set multiplier $argv[1]
    set prefix $argv[2]
    set result ""

    for i in (seq 1 $multiplier)
        set result "$result$prefix"
        if test $i -lt $multiplier
            set result "$result+"
        end
    end

    echo $result
end

set preview_down (fzf_bind_multiply 10 'preview-down')
set preview_up (fzf_bind_multiply 10 'preview-up')

set walker_skip ".git,node_modules,target,.wine,.cache,.cargo,.go,.rye,.steam,.cert,.m2,.zen,.java,.android,.TranslationPlugin,.anydesk,.ansible,.mono,.mozilla,.npm,.ollama,.pki,.renpy,.rustup,.skiko,.spotdl,.supermaven,.terminfo,.lgp,.icons,.gradle,.fleet,.backup,.gnupg,.cups,Google,.javacpp,.lyrics,.purple,.stfolder,Music,.local"
# Preview file content using bat
set -gx FZF_CTRL_T_OPTS "
	  --border-label='Files' --border-label-pos=-4
	  --bind 'alt-p:toggle-preview'
	  --walker-skip $walker_skip
	  --preview 'fzf-preview.sh {}'
	  --header 'Preview <M-p>'"
# <C-y> to copy the command into clipboard using pbcopy
# set -gx FZF_CTRL_R_OPTS "
#   --border-label='Command History' --border-label-pos=-4
#   --bind 'alt-y:execute-silent(echo -n {2..} | wl-copy)+abort'
#   --color header:italic
#   --header 'Copy <M-y>'"
# Print tree structure in the preview window
set -gx FZF_ALT_C_OPTS "
	  --border-label='Directories' --border-label-pos=-4
	  --bind 'alt-p:toggle-preview'
	  --bind 'alt-m:change-multi'
	  --walker-skip $walker_skip
	  --preview 'eza -T --color=always --icons {}'
	  --header 'Preview <M-p>  Multi <M-m>'"

# Respect .gitignore
set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

set -gx DISABLE_FZF_AUTO_COMPLETION false
set -gx DISABLE_FZF_KEY_BINDINGS false

set -gx FZF_DEFAULT_OPTS "
	--height 50% --bind 'ctrl-y:accept,ctrl-f:$preview_down,ctrl-b:$preview_up'
	--color=fg:#ebdbb2,fg+:#fbf1c7,bg:#282828,bg+:#3c3836,gutter:#282828
	--color=hl:#458588,hl+:#458588,info:#d79921,marker:#fb4934
	--color=prompt:#fb4934,spinner:#b8bb26,pointer:#b16286,header:#83a598
	--color=border:#928374,label:#a89984,query:#d5c4a1
	--border='sharp' --border-label='' --preview-window='border-sharp'
	--prompt='  ' --marker='+' --pointer=' ' --separator='─' --scrollbar='│'"

set -gx YT_X_FZF_OPTS "$FZF_DEFAULT_OPTS"

set -e preview_down preview_up fzf_bind_multiply
