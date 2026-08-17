type -q trans; or exit
type -q rlwrap; or exit

function trans -w trans -d 'alias trans=trans'
    command rlwrap trans $argv
end
