if not type -q wget
    exit
end

function wget -w wget -d 'alias wget=wget'
    command wget --hsts-file="$XDG_DATA_HOME/wget-hsts" $argv
end
