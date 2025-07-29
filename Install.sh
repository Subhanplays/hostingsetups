#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Typing effect function
type_text() {
  text="$1"
  delay="${2:-0.02}"
  for ((i=0; i<${#text}; i++)); do
    echo -n "${text:$i:1}"
    sleep "$delay"
  done
  echo
}

# Loading bar function
progress_bar() {
  echo -ne "${CYAN}Loading: ["
  for ((i=0; i<=20; i++)); do
    echo -ne "▓"
    sleep 0.05
  done
  echo -e "] Done!${NC}"
}

# Welcome animation
clear
type_text "💻 Welcome to Subhan's Hosting Installer..." 0.04
progress_bar

# License check
REQUIRED_LICENSE="4358601972"
echo
type_text "${CYAN}=============================="
type_text "      🔐 License Required"
type_text "==============================${NC}"

read -p "$(echo -e ${YELLOW}Enter your license key:${NC} )" user_license

if [[ "$user_license" != "$REQUIRED_LICENSE" ]]; then
  echo -ne "${RED}❌ Invalid license"
  for i in {1..3}; do
    echo -n "."
    sleep 0.4
  done
  echo -e " Please join our Discord to get a valid license.${NC}"
  exit 1
fi

# Menu loop
while true; do
  clear
  echo -e "${CYAN}==============================${NC}"
  echo -e "${CYAN}        🧰 Main Menu${NC}"
  echo -e "${CYAN}==============================${NC}"
  echo -e "${YELLOW}1)${NC} Install Panel"
  echo -e "${YELLOW}2)${NC} Start 24/7 Script"
  echo -e "${YELLOW}3)${NC} Create Tunnel (Playit)"
  echo -e "${YELLOW}0)${NC} Exit"
  echo -e "${CYAN}==============================${NC}"
  read -p "$(echo -e ${GREEN}Choose an option:${NC} )" option

  case $option in
    1)
      type_text "${GREEN}🔧 Installing PufferPanel...${NC}" 0.01
      progress_bar

      bash <(curl -s https://raw.githubusercontent.com/subhanplays/hostingsetups/main/puffer-panel-install)

      type_text "${GREEN}👤 Creating admin user...${NC}" 0.01
      sudo pufferpanel user add

      type_text "${GREEN}🚀 Enabling and starting PufferPanel...${NC}" 0.01
      sudo systemctl enable --now pufferpanel

      echo
      type_text "${CYAN}✅ Made By Subhanplays" 0.03
      type_text "${CYAN}✨ Inspire by Jishnu Gamer${NC}" 0.03
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})"
      ;;
    2)
      type_text "${GREEN}🚀 Running 24/7 script from GitHub...${NC}" 0.01
      progress_bar

      wget -q https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py -O ~/24-7.py
      python3 ~/24-7.py

      echo
      type_text "${CYAN}✅ Made By Subhanplays" 0.03
      type_text "${CYAN}✨ Inspire by Jishnu Gamer${NC}" 0.03
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})"
      ;;
    3)
      type_text "${GREEN}🌐 Downloading and running Playit tunnel...${NC}" 0.01
      progress_bar

      wget -q https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64 -O ~/playit
      chmod +x ~/playit
      ~/playit

      echo
      type_text "${CYAN}✅ Made By Subhanplays" 0.03
      type_text "${CYAN}✨ Inspire by Jishnu Gamer${NC}" 0.03
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})"
      ;;
    0)
      echo -e "${RED}👋 Exiting...${NC}"
      exit 0
      ;;
    *)
      echo -ne "${RED}❌ Invalid option"
      for i in {1..3}; do
        echo -n "."
        sleep 0.4
      done
      echo -e " Restarting menu...${NC}"
      sleep 1
      continue
      ;;
  esac
done
