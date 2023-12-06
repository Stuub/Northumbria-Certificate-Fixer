#!/bin/bash

# ANSI escape codes for color formatting
RESET='\033[0m'
BRIGHT_BOLD_GREEN='\033[1;92m'
WHITE_BOLD='\033[1;208m'

# Update GPG Key & Update Package Lists
update_gpg(){
    printf "${BRIGHT_BOLD_GREEN}Updating GPG Key...${RESET}\n"
    sudo wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc

    printf "${BRIGHT_BOLD_GREEN}GPG Update Done.\n"

    printf "${BRIGHT_BOLD_GREEN}Updating kali...${RESET}\n"
    sudo apt update -y
}
update_gpg

# Download and Install Fortinet Cert System-Wide
fix_ssl(){
    printf "\n${BRIGHT_BOLD_GREEN}Fixing SSL${RESET}\n"
    sudo apt install libnss3-tools -y

    sudo mkdir /usr/local/share/ca-certificates/extra

    sudo wget ftp://192.168.100.252/Fortinet_CA_SSL.cer

    sudo cp Fortinet_CA_SSL.cer /usr/local/share/ca-certificates/extra/

    sudo mv /usr/local/share/ca-certificates/extra/Fortinet_CA_SSL.cer /usr/local/share/ca-certificates/extra/root.crt

    sudo update-ca-certificates

    printf "${BRIGHT_BOLD_GREEN}SSL fixed${RESET}\n"

}
fix_ssl

printf "${BRIGHT_BOLD_GREEN}Thank you for your patience, happy hacking!\n${RESET}"