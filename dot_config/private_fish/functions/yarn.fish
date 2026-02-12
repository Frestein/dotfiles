if not type -q yarn
    exit
end

function yarn -w yarn -d 'alias yarn=yarn'
    command yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config" $argv
end
