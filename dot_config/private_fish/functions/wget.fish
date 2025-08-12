function wget --wraps=wget --description 'alias wget=wget'
    command wget --hsts-file="$XDG_DATA_HOME/wget-hsts" $argv
end
