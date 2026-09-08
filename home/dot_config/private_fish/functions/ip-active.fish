function ip-active -d 'Show active network interfaces'
    ip -br link show | awk '$2 == "UP" {print $1}'
end
