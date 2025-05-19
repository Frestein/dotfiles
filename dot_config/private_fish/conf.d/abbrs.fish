if not status is-interactive && test "$CI" != true
    exit
end

abbr -a -- a ansible
abbr -a -- bc bc -q
abbr -a -- btmb btm -b --hide_avg_cpu --theme gruvbox
abbr -a -- cz chezmoi
abbr -a -- d docker
abbr -a -- ddg BROWSER=links ddgr
abbr -a -- news newsboat
abbr -a -- sc systemctl
abbr -a -- scu systemctl --user
abbr -a -- speedtest speedtest-go
abbr -a -- y yazi
abbr -a -- tb nc termbin.com 9999

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

abbr -a -- t trans :ru
abbr -a -- tl trans :ru --shell --brief
abbr -a -- tt trans :en
abbr -a -- ttl trans :en --shell --brief

abbr -a -- v nvim
abbr -a -- vd nvim -d
abbr -a -- vz nvim -c \'Telescope zoxide list\'
abbr -a -- vc nvim -c \'Telescope chezmoi find_files\'

abbr -a -- ec emacsclient -nc
abbr -a -- ew emacsclient -nw

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
    abbr -a -- yaorph yay -Qtd
    abbr -a -- yainsd yay -S --asdeps
    abbr -a -- yamir yay -Syy
    abbr -a -- yaupd yay -Sy
end
