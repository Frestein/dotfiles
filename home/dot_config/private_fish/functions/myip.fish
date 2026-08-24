function myip -d 'Show your public IP address'
    dig +short myip.opendns.com @resolver1.opendns.com $argv
end
