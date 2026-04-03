# ============================================================================
# Aliases for the interactive usage
# ============================================================================

# Stop execution if the shell is not interactive
if not status is-interactive && test "$CI" != true
    exit
end

# ----------------------------------------------------------------------------
# Force XDG paths
# ----------------------------------------------------------------------------
alias wget 'wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias yarn 'yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias tgeraser 'tgeraser -d "$XDG_DATA_HOME/tgeraser"'
