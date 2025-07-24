#!/usr/bin/env sh

# better defaults
alias bc='bc -q'
alias btm='btm -b --hide_avg_cpu --theme gruvbox'
alias path='echo "$PATH" | tr ":" " "'
alias path_list='echo "$PATH" | tr ":" "\n" | sort'

# clipboard
alias clipboard_history="cliphist list | fzf -d $'\t' --with-nth 2 | cliphist decode | wl-copy"

# trans
alias t='trans :ru'
alias tt='trans :en'
alias tl='trans :ru --shell --brief'
alias ttl='trans :en --shell --brief'

# share files
alias tb='nc termbin.com 9999'

# fetch
alias f='fastfetch'
alias ff='fastfetch -c $XDG_CONFIG_HOME/fastfetch/config-full.jsonc'

# eza
EZA_DEFAULTS='--group --group-directories-first'

alias lD="eza -lD $EZA_DEFAULTS"
alias lS="eza -lS $EZA_DEFAULTS"
alias lT="eza -lT $EZA_DEFAULTS"
alias laD="eza -laD $EZA_DEFAULTS"
alias ldot="eza -ld -a $EZA_DEFAULTS"
alias l="eza -l $EZA_DEFAULTS"
alias ll="eza -la $EZA_DEFAULTS"
alias lr="eza -R $EZA_DEFAULTS"
alias ls="eza $EZA_DEFAULTS"
alias lsd="eza -d $EZA_DEFAULTS"
alias lsdl="eza -dl $EZA_DEFAULTS"

unset EZA_DEFAULTS

# yazi
alias y='yazi'

# nvim
alias v='nvim'
alias vd='nvim -d'

# helix
alias hx='helix'

# emacs
alias ec='emacsclient -nc'
alias ew='emacsclient -nw'
alias dm='doom'

# chezmoi
alias cz='chezmoi'

# ansible
alias a='ansible'

# docker
alias d='docker'

# systemd
alias sc='systemctl'
alias scu='systemctl --user'
# Get the error messages from journalctl
alias jctl='journalctl -p 3 -xb'

# network
alias speedtest='speedtest-go'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Arch Linux

# Recent installed packages
alias pacrip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Additional info: https://wiki.archlinux.org/index.php/Pacman_Tips
alias pacupg='doas pacman -Syu'
alias pacin='doas pacman -S'
alias paclean='doas pacman -Sc'
alias pacins='doas pacman -U'
alias paclr='doas pacman -Scc'
alias pacre='doas pacman -R'
alias pacrem='doas pacman -Rns'
alias pacrep='pacman -Si'
alias pacreps='pacman -Ss'
alias pacloc='pacman -Qi'
alias paclocs='pacman -Qs'
alias pacinsd='doas pacman -S --asdeps'
alias pacmir='doas pacman -Syy'
alias paclsorphans='doas pacman -Qdt'
alias pacrmorphans='doas pacman -Rs $(pacman -Qtdq)'
alias pacfileupg='doas pacman -Fy'
alias pacfiles='pacman -F'
alias pacls='pacman -Ql'
alias pacown='pacman -Qo'
alias pacupd="doas pacman -Sy"
alias pacmanallkeys='doas pacman-key --refresh-keys'

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
    alias yaupd="yay -Sy"
fi
