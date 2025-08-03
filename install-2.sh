#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# License Key Check
VALID_LICENSE_KEY="126575"
read -rp "$(echo -e ${CYAN}Enter your license key:${NC} )" input_key

if [[ "$input_key" != "$VALID_LICENSE_KEY" ]]; then
    echo -e "${RED}Invalid license key. Exiting installer.${NC}"
    exit 1
fi

echo -e "${GREEN}License key verified!${NC}"
sleep 1
clear

# Installer Menu
echo -e "${CYAN}==============================="
echo -e " ${GREEN}Skyport Installer Menu${CYAN}"
echo -e "===============================${NC}"
echo -e "${YELLOW}1)${NC} Install Panel"
echo -e "${YELLOW}2)${NC} Install Wings / Node"
echo -e "${YELLOW}3)${NC} Install 24/7 Script"
echo -e "${YELLOW}4)${NC} Exit"
echo -e "==============================="
read -rp "$(echo -e ${CYAN}Choose an option [1-4]:${NC} )" choice

install_panel() {
  echo -e "${GREEN}Installing Panel...${NC}"
  bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/skyport-install.sh)
  echo -e "${GREEN}Panel installation completed.${NC}"
}

install_wings() {
  echo -e "${GREEN}Installing Wings / Node...${NC}"
  bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/wing.sh)
  echo -e "${GREEN}Changing directory to skyportd...${NC}"
  cd skyportd || { echo -e "${RED}Directory 'skyportd' not found!${NC}"; exit 1; }
  echo -e "${YELLOW}Please paste your node configuration now (edit files as needed).${NC}"
  echo -e "${YELLOW}After configuration, start node with: pm2 start .${NC}"
}

install_24_7() {
  echo -e "${GREEN}Installing 24/7 script...${NC}"
  curl -O https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py
  echo -e "${GREEN}Running 24/7 script with python3...${NC}"
  python3 24-7.py
  echo -e "${GREEN}24/7 script started.${NC}"
}

case $choice in
  1)
    install_panel
    ;;
  2)
    install_wings
    ;;
  3)
    install_24_7
    ;;
  4)
    echo -e "${CYAN}Exiting installer.${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid option. Exiting.${NC}"
    exit 1
    ;;
esac
