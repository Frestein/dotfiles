if not status is-interactive && test "$CI" != true
    exit
end

set -q XDG_CACHE_HOME; or set -x XDG_CACHE_HOME $HOME/.cache
set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME; or set -x XDG_DATA_HOME $HOME/.local/share
set -q XDG_RUNTIME_DIR; or set -x XDG_RUNTIME_DIR /run/user/(id -u)
set -q XDG_STATE_HOME; or set -x XDG_STATE_HOME $HOME/.local/state

set -q BUN_HOME; or set -x BUN_HOME $XDG_DATA_HOME/bun
set -q CARGO_HOME; or set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -q RUSTUP_HOME; or set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -q GOPATH; or set -x GOPATH $XDG_DATA_HOME/go

function prepend_unique_path
    for dir in $argv
        if not contains -- $dir $PATH
            set -x PATH $dir $PATH
        end
    end
end

prepend_unique_path $BUN_HOME/bin $GOPATH/bin $CARGO_HOME/bin $XDG_CONFIG_HOME/doom.d/bin $HOME/.local/bin

set -q SCREENRC; or set -x SCREENRC $XDG_CONFIG_HOME/screen/screenrc
set -q EMACSDIR; or set -x EMACSDIR $XDG_CONFIG_HOME/doom.d
set -q GNUPGHOME; or set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -q SSH_AUTH_SOCK; or set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set -q PASSWORD_STORE_DIR; or set -x PASSWORD_STORE_DIR $XDG_DATA_HOME/gopass/stores/root
set -q NPM_CONFIG_USERCONFIG; or set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -q RENPY_PATH_TO_SAVES; or set -x RENPY_PATH_TO_SAVES $XDG_DATA_HOME/renpy
set -q WINEPREFIX; or set -x WINEPREFIX $XDG_DATA_HOME/wine
set -q PYTHONSTARTUP; or set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc
set -q _JAVA_OPTIONS; or set -x _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
set -q NUGET_PACKAGES; or set -x NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages
set -q DOTNET_CLI_HOME; or set -x DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
set -q RLWRAP_HOME; or set -x RLWRAP_HOME $XDG_DATA_HOME/rlwrap
set -q CUPS_CONFIG_DIR; or set -x CUPS_CONFIG_DIR $XDG_CONFIG_HOME/cups
set -q CUPS_CACHE_DIR; or set -x CUPS_CACHE_DIR $XDG_CACHE_HOME/cups
set -q CUPS_DATA_DIR; or set -x CUPS_DATA_DIR $XDG_DATA_HOME/cups

set -q VISUAL; or set -x VISUAL nvim
set -q EDITOR; or set -x EDITOR $VISUAL

set -q TERMINAL; or set -x TERMINAL footclient
set -q TERM; or set -x TERM $TERMINAL
set -q TERMCMD; or set -x TERMCMD "$TERMINAL --title='foot-yazi-flt'"

set -q BROWSER; or set -x BROWSER qutebrowser

set -q DIFFPROG; or set -x DIFFPROG 'nvim -d'
set -q MANPAGER; or set -x MANPAGER 'nvim +Man!'
set -q PAGER; or set -x PAGER less
set -q LESS; or set -x LESS '-i -M -F'

set -q BAT_THEME; or set -x BAT_THEME gruvbox-dark

set -q DOTNET_CLI_TELEMETRY_OPTOUT; or set -x DOTNET_CLI_TELEMETRY_OPTOUT 1
set -q POWERSHELL_TELEMETRY_OPTOUT; or set -x POWERSHELL_TELEMETRY_OPTOUT 1

set -q DMENU; or set -x DMENU "fuzzel -d"

set -q SUDO_ASKPASS; or set -x SUDO_ASKPASS $HOME/.local/bin/askpass
set -q DOAS_ASKPASS; or set -x DOAS_ASKPASS $SUDO_ASKPASS

set -q VDPAU_DRIVER; or set -x VDPAU_DRIVER radeonsi
set -q LIBVA_DRIVER_NAME; or set -x LIBVA_DRIVER_NAME radeonsi
