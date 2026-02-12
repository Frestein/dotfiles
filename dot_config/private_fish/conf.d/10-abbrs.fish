if not status is-interactive && test "$CI" != true
    exit
end

abbr -a -- q exit
abbr -a -- c clear

if type -q bc
    abbr -a -- bc bc -q
end

if type -q btm
    abbr -a -- btm btm -b --hide_avg_cpu
end

if type -q trans
    abbr -a -- t trans :ru
    abbr -a -- tt trans :en
    abbr -a -- tl trans :ru --shell --brief
    abbr -a -- ttl trans :en --shell --brief
end

abbr -a -- tb nc termbin.com 9999 # Share files

if type -q fastfetch
    abbr -a -- f fastfetch
    abbr -a -- ff fastfetch -c $XDG_CONFIG_HOME/fastfetch/config-full.jsonc
end

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

if type -q chezmoi
    abbr -a -- cz chezmoi
    abbr -a -- czx env CZ_EXT=1 chezmoi
end

if type -q ansbile
    abbr -a -- a ansible
end

if type -q docker
    abbr -a -- d docker
end

if type -q systemd
    abbr -a -- sc systemctl
    abbr -a -- scu systemctl --user
    abbr -a -- jctl journalctl -p 3 -xb # Get the error messages from journalctl
end

if type -q speedtest-go
    abbr -a -- speedtest speedtest-go
end

if type -q pacman
    abbr -a -- pacrip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl" # Recent installed packages
    abbr -a -- pacupg doas pacman -Syu
    abbr -a -- pacin doas pacman -S
    abbr -a -- paclean doas pacman -Sc
    abbr -a -- pacins doas pacman -U
    abbr -a -- paclr doas pacman -Scc
    abbr -a -- pacre doas pacman -R
    abbr -a -- pacrem doas pacman -Rns
    abbr -a -- pacrep pacman -Si
    abbr -a -- pacreps pacman -Ss
    abbr -a -- pacloc pacman -Qi
    abbr -a -- paclocs pacman -Qs
    abbr -a -- paclst pacman -Qe
    abbr -a -- paclsta "pacman -Qem | awk '{print \$1}' | xargs expac --timefmt=\"%F %T\" \"[%l] \$(printf '\\033[1;35m')%n\$(printf '\\033[0m') \$(printf '\\033[0;37m')(%v)\$(printf '\\033[0m')\" | sort -k3"
    abbr -a -- pacinsd doas pacman -S --asdeps
    abbr -a -- pacmir doas pacman -Syy
    abbr -a -- paclsorphans doas pacman -Qdt
    abbr -a -- pacrmorphans doas pacman -Rs '(pacman -Qtdq)'
    abbr -a -- pacfileupg doas pacman -Fy
    abbr -a -- pacfiles pacman -F
    abbr -a -- pacls pacman -Ql
    abbr -a -- pacown pacman -Qo
    abbr -a -- pacupd doas pacman -Sy
    abbr -a -- pacmanallkeys doas pacman-key --refresh-keys
end

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
