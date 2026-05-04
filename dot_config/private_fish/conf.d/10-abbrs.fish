# ============================================================================
# Abbreviations for the interactive usage
# ============================================================================

# Stop execution if the shell is not interactive
if not status is-interactive && test "$CI" != true
    exit
end

# ----------------------------------------------------------------------------
# Quick abbreviations
# ----------------------------------------------------------------------------
abbr -a -- q exit
abbr -a -- c clear

# ----------------------------------------------------------------------------
# Better defaults
# ----------------------------------------------------------------------------
if type -q bc
    abbr -a -- bc bc -q
end

if type -q btm
    abbr -a -- btm btm -b --hide_avg_cpu
end

# ----------------------------------------------------------------------------
# Clipboard management
# ----------------------------------------------------------------------------
abbr -a -- clipfzf 'cliphist list | fzf -d "\t" --with-nth 2 | cliphist decode | wl-copy'

# ----------------------------------------------------------------------------
# Translation (trans)
# ----------------------------------------------------------------------------
if type -q trans
    abbr -a -- t trans :ru
    abbr -a -- tt trans :en
    abbr -a -- tl trans :ru --shell --brief
    abbr -a -- ttl trans :en --shell --brief
end

# ----------------------------------------------------------------------------
# File sharing
# ----------------------------------------------------------------------------
abbr -a -- tb nc termbin.com 9999

# ----------------------------------------------------------------------------
# Fastfetch
# ----------------------------------------------------------------------------
if type -q fastfetch
    abbr -a -- f fastfetch
    abbr -a -- ff fastfetch -c $XDG_CONFIG_HOME/fastfetch/config-full.jsonc
end

# ----------------------------------------------------------------------------
# Eza
# ----------------------------------------------------------------------------
if type -q eza
    set EZA_DEFAULTS --group --group-directories-first

    abbr -a -- lD eza -lD $EZA_DEFAULTS
    abbr -a -- lS eza -lS $EZA_DEFAULTS
    abbr -a -- lT eza -lT $EZA_DEFAULTS
    abbr -a -- laD eza -laD $EZA_DEFAULTS
    abbr -a -- ldot eza -ld -a $EZA_DEFAULTS
    abbr -a -- l eza -l $EZA_DEFAULTS
    abbr -a -- ll eza -la $EZA_DEFAULTS
    abbr -a -- lr eza -R $EZA_DEFAULTS
    abbr -a -- ls eza $EZA_DEFAULTS
    abbr -a -- lsd eza -d $EZA_DEFAULTS
    abbr -a -- lsdl eza -dl $EZA_DEFAULTS

    set -e EZA_DEFAULTS
end

# ----------------------------------------------------------------------------
# Editors & File Manager
# ----------------------------------------------------------------------------
if type -q yazi
    abbr -a -- y yazi
end

if type -q nvim
    abbr -a -- v nvim
    abbr -a -- vd nvim -d
end

if type -q helix
    abbr -a -- hx helix
end

if type -q emacs
    abbr -a -- ec emacsclient -nc
    abbr -a -- ew emacsclient -nw
    abbr -a -- dm doom
end

# ----------------------------------------------------------------------------
# Dotfiles (Chezmoi)
# ----------------------------------------------------------------------------
if type -q chezmoi
    abbr -a -- cz chezmoi
    abbr -a -- czx env CZ_EXT=1 chezmoi
end

# ----------------------------------------------------------------------------
# Ansible
# ----------------------------------------------------------------------------
if type -q ansible
    abbr -a -- a ansible
end

# ----------------------------------------------------------------------------
# Docker
# ----------------------------------------------------------------------------
if type -q docker
    abbr -a -- d docker
end

# ----------------------------------------------------------------------------
# Systemd
# ----------------------------------------------------------------------------
if type -q systemctl
    abbr -a -- sc systemctl
    abbr -a -- scu systemctl --user
end

if type -q journalctl
    # Get the error messages
    abbr -a -- jctl journalctl -p 3 -xb
end

# ----------------------------------------------------------------------------
# Network
# ----------------------------------------------------------------------------
if type -q speedtest-go
    abbr -a -- speedtest speedtest-go
end

abbr -a -- myip 'dig +short myip.opendns.com @resolver1.opendns.com'
abbr -a -- ips "ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# ----------------------------------------------------------------------------
# Arch Linux: Pacman
# ----------------------------------------------------------------------------
if type -q pacman
    # Recently installed packages
    abbr -a -- pacrip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
    abbr -a -- pacupg asroot pacman -Syu
    abbr -a -- pacin asroot pacman -S
    abbr -a -- paclean asroot pacman -Sc
    abbr -a -- pacins asroot pacman -U
    abbr -a -- paclr asroot pacman -Scc
    abbr -a -- pacre asroot pacman -R
    abbr -a -- pacrem asroot pacman -Rns
    abbr -a -- pacrep pacman -Si
    abbr -a -- pacreps pacman -Ss
    abbr -a -- pacloc pacman -Qi
    abbr -a -- paclocs pacman -Qs
    abbr -a -- paclst pacman -Qe
    abbr -a -- paclsta "pacman -Qem | awk '{print \$1}' | xargs expac --timefmt=\"%F %T\" \"[%l] \$(printf '\\033[1;35m')%n\$(printf '\\033[0m') \$(printf '\\033[0;37m')(%v)\$(printf '\\033[0m')\" | sort -k3"
    abbr -a -- pacinsd asroot pacman -S --asdeps
    abbr -a -- pacmir asroot pacman -Syy
    abbr -a -- paclsorphans asroot pacman -Qdt
    abbr -a -- pacrmorphans asroot pacman -Rs '(pacman -Qtdq)'
    abbr -a -- pacfileupg asroot pacman -Fy
    abbr -a -- pacfiles pacman -F
    abbr -a -- pacls pacman -Ql
    abbr -a -- pacown pacman -Qo
    abbr -a -- pacupd asroot pacman -Sy
    abbr -a -- pacmanallkeys asroot pacman-key --refresh-keys
end

# ----------------------------------------------------------------------------
# Arch Linux: Yay (AUR helper)
# ----------------------------------------------------------------------------
if type -q yay
    abbr -a -- yaconf yay -Pg
    abbr -a -- yaclean yay -Sc
    abbr -a -- yaclr yay -Scc
    abbr -a -- yaupg yay -Syu
    abbr -a -- yasu yay -Syu --noconfirm
    abbr -a -- yain yay -S
    abbr -a -- yains yay -U
    abbr -a -- yare yay -R
    abbr -a -- yarem yay -Rns
    abbr -a -- yarep yay -Si
    abbr -a -- yareps yay -Ss
    abbr -a -- yaloc yay -Qi
    abbr -a -- yalocs yay -Qs
    abbr -a -- yalst yay -Qe
    abbr -a -- yalsta "yay -Qem | awk '{print \$1}' | xargs expac --timefmt=\"%F %T\" \"[%l] \$(printf '\\033[1;35m')%n\$(printf '\\033[0m') \$(printf '\\033[0;37m')(%v)\$(printf '\\033[0m')\" | sort -k3"
    abbr -a -- yaorph yay -Qtd
    abbr -a -- yainsd yay -S --asdeps
    abbr -a -- yamir yay -Syy
    abbr -a -- yaupd yay -Sy
end
