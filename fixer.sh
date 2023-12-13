#!/bin/bash

# ANSI escape codes for color formatting
RESET='\033[0m'
BRIGHT_BOLD_GREEN='\033[1;92m'
WHITE_BOLD='\033[1;208m'

update_gpg(){
    printf "${BRIGHT_BOLD_GREEN}Updating GPG Key...${RESET}\n"
    sudo wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc

    printf "${BRIGHT_BOLD_GREEN}GPG Update Done."

    printf "${BRIGHT_BOLD_GREEN}Updating kali...${RESET}"
    sudo apt update -y

    printf "${BRIGHT_BOLD_GREEN}Thank you for your patience, happy hacking!\n${RESET}"
}
update_gpg

fix_ssl(){
    printf "\n${BRIGHT_BOLD_GREEN}Fixing SSL${RESET}\n"
    sudo apt install libnss3-tools -y

    sudo mkdir /usr/local/share/ca-certificates/extra

    sudo wget ftp://192.168.100.252/Fortinet_CA_SSL.cer

    sudo cp Fortinet_CA_SSL.cer /usr/local/share/ca-certificates/extra/

    sudo cp /usr/local/share/ca-certificates/extra/Fortinet_CA_SSL.cer /usr/local/share/ca-certificates/extra/root.crt

    sudo update-ca-certificates

    printf "\n${BRIGHT_BOLD_GREEN}System Wide Certificate Added.${RESET}\n"

}
fix_ssl

firefox_ssl(){
    printf "\n${WHITE_BOLD}Adding Cert to Firefox...${RESET}"
    sleep 2
    sudo rm /usr/lib/firefox-esr/distribution/policies.json
    sudo echo -e '''{
    "policies": {
        "Certificates": {
            "Install": [
                "/usr/local/share/ca-certificates/extra/Fortinet_CA_SSL.cer"]
        }
    },
    "DisplayBookmarksToolbar": true,
        "NoDefaultBookmarks": true,
        "Homepage": {
        "URL": "file:///usr/share/kali-defaults/web/homepage.html",
        "Locked": false,
        "StartPage": "homepage"
        },
        "DisableTelemetry": true,
        "NetworkPrediction": false,
        "DNSOverHTTPS": {
        "Enabled": false
        },
        "CaptivePortal": false,
        "FirefoxHome": {
        "Search": true,
        "TopSites": true,
        "Highlights": false,
        "Pocket": false,
        "Snippets": false,
        "Locked": false
        }
    } ''' >> /usr/lib/firefox-esr/distribution/policies.json

    printf "\n${BRIGHT_BOLD_GREEN}\nAll finished :) ${RESET}\n"
}
firefox_ssl
