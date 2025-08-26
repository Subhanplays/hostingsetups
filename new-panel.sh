#!/bin/bash
# V4Panel Auto Installer & Manager
# Made by Subhan Zahid

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

show_menu() {
  clear
  echo -e "${GREEN}====== V4Panel Setup & Manager ======${RESET}"
  echo "1) Install & Setup V4Panel"
  echo "2) Start Panel"
  echo "3) Run Panel 24/7 (PM2)"
  echo "4) Setup Playit Tunnel (Get Public IP)"
  echo "5) Exit"
  echo -n "Choose an option: "
}

install_v4panel() {
  echo -e "${YELLOW}Installing dependencies...${RESET}"
  curl -sL https://deb.nodesource.com/setup_23.x | sudo bash -
  sudo apt-get install -y nodejs git zip unzip wget

  echo -e "${YELLOW}Cloning repository...${RESET}"
  if [ ! -d "v4panel" ]; then
    git clone https://github.com/teryxlabs/v4panel
  fi

  cd v4panel || exit

  echo -e "${YELLOW}Unzipping panel...${RESET}"
  unzip -o panel.zip

  echo -e "${YELLOW}Installing npm dependencies...${RESET}"
  npm install
  npm run seed
  npm run createUser

  echo -e "${GREEN}✅ V4Panel Installed Successfully!${RESET}"
}

start_panel() {
  cd v4panel || exit
  echo -e "${YELLOW}Starting panel...${RESET}"
  node .
}

run_pm2() {
  cd v4panel || exit
  echo -e "${YELLOW}Installing PM2...${RESET}"
  sudo npm install -g pm2
  pm2 start index.js --name v4panel
  pm2 save
  pm2 startup
  echo -e "${GREEN}✅ Panel is now running 24/7 with PM2${RESET}"
}

setup_playit() {
  echo -e "${YELLOW}Downloading Playit Tunnel...${RESET}"
  wget -O playit-linux-amd64 https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64
  chmod +x playit-linux-amd64
  echo -e "${YELLOW}Starting Playit Tunnel...${RESET}"
  ./playit-linux-amd64
}

while true; do
  show_menu
  read -r choice
  case $choice in
    1) install_v4panel ;;
    2) start_panel ;;
    3) run_pm2 ;;
    4) setup_playit ;;
    5) echo "Exiting..."; exit 0 ;;
    *) echo -e "${RED}Invalid choice!${RESET}" ;;
  esac
  echo -e "\nPress Enter to continue..."
  read -r
done
