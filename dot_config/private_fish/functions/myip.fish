function myip --description 'Show your public IP address'
    dig +short myip.opendns.com @resolver1.opendns.com $argv
end
