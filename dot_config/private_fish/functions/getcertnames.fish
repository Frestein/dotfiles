function getcertnames --description 'Show all the names (CNs and SANs) listed in the SSL certificate for a given domain'
    if test (count $argv) -eq 0
        echo "Usage: getcertnames <domain>"
        return 1
    end

    set domain $argv[1]
    echo "Testing $domain…"
    echo ""

    set tmp (echo -e "GET / HTTP/1.0\nEOT" | openssl s_client -connect "$domain:443" -servername "$domain" 2>&1)

    if printf "%s\n" $tmp | grep -q -- "-----BEGIN CERTIFICATE-----"
        set certText (printf "%s\n" $tmp |
			openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version")

        echo "Common Name:"
        echo ""
        printf "%s\n" $certText | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//"
        echo ""
        echo "Subject Alternative Name(s):"
        echo ""
        printf "%s\n" $certText | grep -A 1 "Subject Alternative Name:" | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    else
        echo "ERROR: Certificate not found."
        return 1
    end
end

