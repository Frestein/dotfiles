function yarn --wraps=yarn --description 'alias yarn=yarn'
    command yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config" $argv
end
