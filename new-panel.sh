#!/bin/bash
# VPS + Node + 24/7 + Playit Installer
# Made by Subhanplays

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

print_menu() {
  clear
  echo -e "${GREEN}====== VPS & Node Installer ======${RESET}"
  echo "1) Install panel"
  echo "2) Install Node.js"
  echo "3) Start Node"
  echo "4) Run 24/7 Script"
  echo "5) Setup Playit Tunnel"
  echo "0) Exit"
  echo -ne "${YELLOW}Choose option: ${RESET}"
}

install_vps() {
  echo -e "${YELLOW}Installing Jishnu VPS script...${RESET}"
  sudo bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/new-panel-1.sh)
  echo -e "${GREEN}✅ VPS Script Installed${RESET}"
}

install_node() {
  echo -e "${YELLOW}Installing Node.js...${RESET}"
  sudo bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/new-panel-wing.sh)
  cd node || exit
  echo -e "${GREEN}✅ Node Installed. Paste your configuration inside 'node' folder.${RESET}"
}

start_node_app() {
  cd node || exit
  echo -e "${YELLOW}Starting Node App...${RESET}"
  node .
}

run_24_7() {
  echo -e "${YELLOW}Downloading 24/7 script...${RESET}"
  wget -q https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py -O ~/24-7.py
  echo -e "${YELLOW}Running 24/7 script...${RESET}"
  python3 ~/24-7.py
}

setup_playit() {
  echo -e "${YELLOW}Downloading Playit Tunnel...${RESET}"
  wget -O playit-linux-amd64 https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64
  chmod +x playit-linux-amd64
  echo -e "${YELLOW}Starting Playit Tunnel...${RESET}"
  ./playit-linux-amd64
}

while true; do
  print_menu
  read -r choice
  case $choice in
    1) install_vps ;;
    2) install_node ;;
    3) start_node_app ;;
    4) run_24_7 ;;
    5) setup_playit ;;
    0) echo -e "${GREEN}Exiting...${RESET}"; exit 0 ;;
    *) echo -e "${RED}Invalid option!${RESET}" ;;
  esac
  echo -e "\nPress Enter to continue..."
  read -r
done
