if not type -q trans
    exit
end

if not type -q rlwrap
    exit
end

function trans -w trans -d 'alias trans=trans'
    command rlwrap trans $argv
end
