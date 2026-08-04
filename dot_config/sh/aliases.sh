# ============================================================================
# Aliases for the interactive POSIX shell
# ============================================================================

# Stop execution if the shell is not interactive
case $- in
*i*) ;;
*) exit 0 ;;
esac

# ----------------------------------------------------------------------------
# Force XDG paths
# ----------------------------------------------------------------------------
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'

# ----------------------------------------------------------------------------
# Quick aliases
# ----------------------------------------------------------------------------
alias q='exit'
alias c='clear'

# ----------------------------------------------------------------------------
# Better defaults
# ----------------------------------------------------------------------------
if command -v bc >/dev/null 2>&1; then
    alias bc='bc -q'
fi

if command -v btm >/dev/null 2>&1; then
    alias btm='btm -b --hide_avg_cpu'
fi

alias path='echo "$PATH" | tr ":" " "'
alias path_list='echo "$PATH" | tr ":" "\n" | sort'

# ----------------------------------------------------------------------------
# Clipboard management
# ----------------------------------------------------------------------------
alias clipfzf='cliphist list | fzf -d $'\t' --with-nth 2 | cliphist decode | wl-copy'

# ----------------------------------------------------------------------------
# Translation (trans)
# ----------------------------------------------------------------------------
if command -v trans >/dev/null 2>&1; then
    alias t='trans :ru'
    alias tt='trans :en'
    alias tl='trans :ru --shell --brief'
    alias ttl='trans :en --shell --brief'
fi

# ----------------------------------------------------------------------------
# File sharing
# ----------------------------------------------------------------------------
alias tb='nc termbin.com 9999'

# ----------------------------------------------------------------------------
# Fastfetch
# ----------------------------------------------------------------------------
if command -v fastfetch >/dev/null 2>&1; then
    alias f='fastfetch'
    alias ff='fastfetch -c "$XDG_CONFIG_HOME/fastfetch/config-full.jsonc"'
fi

# ----------------------------------------------------------------------------
# Eza
# ----------------------------------------------------------------------------
if command -v eza >/dev/null 2>&1; then
    _eza_defaults='--group --group-directories-first'

    alias lD="eza -lD $_eza_defaults"
    alias lS="eza -lS $_eza_defaults"
    alias lT="eza -lT $_eza_defaults"
    alias laD="eza -laD $_eza_defaults"
    alias ldot="eza -ld -a $_eza_defaults"
    alias l="eza -l $_eza_defaults"
    alias ll="eza -la $_eza_defaults"
    alias lr="eza -R $_eza_defaults"
    alias ls="eza $_eza_defaults"
    alias lsd="eza -d $_eza_defaults"
    alias lsdl="eza -dl $_eza_defaults"

    unset _eza_defaults
fi

# ----------------------------------------------------------------------------
# Editors & File Manager
# ----------------------------------------------------------------------------
if command -v yazi >/dev/null 2>&1; then
    alias y='yazi'
fi

if command -v nvim >/dev/null 2>&1; then
    alias v='nvim'
    alias vd='nvim -d'
fi

if command -v helix >/dev/null 2>&1; then
    alias hx='helix'
fi

if command -v emacsclient >/dev/null 2>&1 && command -v emacs >/dev/null 2>&1; then
    alias ec='emacsclient -nc'
    alias ew='emacsclient -nw'
    if command -v doom >/dev/null 2>&1; then
        alias dm='doom'
    fi
fi

# ----------------------------------------------------------------------------
# Dotfiles (Chezmoi)
# ----------------------------------------------------------------------------
if command -v chezmoi >/dev/null 2>&1; then
    alias cz='chezmoi'
    alias czx='CZ_EXT=1 chezmoi'
fi

# ----------------------------------------------------------------------------
# Ansible
# ----------------------------------------------------------------------------
if command -v ansible >/dev/null 2>&1; then
    alias a='ansible'
fi

# ----------------------------------------------------------------------------
# Docker
# ----------------------------------------------------------------------------
if command -v docker >/dev/null 2>&1; then
    alias d='docker'
fi

# ----------------------------------------------------------------------------
# Systemd
# ----------------------------------------------------------------------------
if command -v systemctl >/dev/null 2>&1; then
    alias sc='systemctl'
    alias scu='systemctl --user'
fi

if command -v journalctl >/dev/null 2>&1; then
    # Get the error messages
    alias jctl='journalctl -p 3 -xb'
fi

# ----------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------
if command -v speedtest-go >/dev/null 2>&1; then
    alias speedtest='speedtest-go'
fi

alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# ----------------------------------------------------------------------------
# Arch Linux: Pacman
# ----------------------------------------------------------------------------
if command -v pacman >/dev/null 2>&1; then
    # Recently installed packages
    alias pacrip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    alias pacupg='asroot pacman -Syu'
    alias pacin='asroot pacman -S'
    alias paclean='asroot pacman -Sc'
    alias pacins='asroot pacman -U'
    alias paclr='asroot pacman -Scc'
    alias pacre='asroot pacman -R'
    alias pacrem='asroot pacman -Rns'
    alias pacrep='pacman -Si'
    alias pacreps='pacman -Ss'
    alias pacloc='pacman -Qi'
    alias paclocs='pacman -Qs'
    alias pacinsd='asroot pacman -S --asdeps'
    alias pacmir='asroot pacman -Syy'
    alias paclsorphans='asroot pacman -Qdt'
    alias pacfileupg='asroot pacman -Fy'
    alias pacfiles='pacman -F'
    alias pacls='pacman -Ql'
    alias pacown='pacman -Qo'
    alias pacupd='asroot pacman -Sy'
    alias pacmanallkeys='asroot pacman-key --refresh-keys'

    # Removing orphan packages
    pacrmorphans() {
        asroot pacman -Rs $(pacman -Qtdq)
    }

    # List of explicitly installed packages
    alias paclst='pacman -Qe'
    paclsta() {
        pacman -Qem | awk '{print $1}' | xargs expac --timefmt="%F %T" "[%l] $(printf '\033[1;35m')%n$(printf '\033[0m') $(printf '\033[0;37m')(%v)$(printf '\033[0m')" | sort -k3
    }
fi

# ----------------------------------------------------------------------------
# Arch Linux: Yay (AUR helper)
# ----------------------------------------------------------------------------
if command -v yay >/dev/null 2>&1; then
    alias yaconf='yay -Pg'
    alias yaclean='yay -Sc'
    alias yaclr='yay -Scc'
    alias yaupg='yay -Syu'
    alias yasu='yay -Syu --noconfirm'
    alias yain='yay -S'
    alias yains='yay -U'
    alias yare='yay -R'
    alias yarem='yay -Rns'
    alias yarep='yay -Si'
    alias yareps='yay -Ss'
    alias yaloc='yay -Qi'
    alias yalocs='yay -Qs'
    alias yalst='yay -Qe'
    alias yaorph='yay -Qtd'
    alias yainsd='yay -S --asdeps'
    alias yamir='yay -Syy'
    alias yaupd='yay -Sy'

    yalsta() {
        yay -Qem | awk '{print $1}' | xargs expac --timefmt="%F %T" "[%l] $(printf '\033[1;35m')%n$(printf '\033[0m') $(printf '\033[0;37m')(%v)$(printf '\033[0m')" | sort -k3
    }
fi
