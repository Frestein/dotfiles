type -q yarn; or exit

function yarn -w yarn -d 'alias yarn=yarn'
    command yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config" $argv
end
