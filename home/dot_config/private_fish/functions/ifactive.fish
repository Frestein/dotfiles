function ifactive -d 'Show active network interfaces'
    ifconfig | grep 'flags=' | grep UP | awk -F: '{print $1}'
end
