#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# License check
LICENSE_FILE="$HOME/.myscript_license"
CORRECT_LICENSE="1cfsa2sddv4d"

if [[ ! -f "$LICENSE_FILE" ]]; then
  echo -e "${CYAN}🔐 License Required!${NC}"
  echo -e "Join our Discord to get your license key:"
  echo -e "${YELLOW}👉 https://discord.gg/aSXyvaAnZN${NC}"
  echo ""

  read -p "Enter your license key: " user_license

  if [[ "$user_license" == "$CORRECT_LICENSE" ]]; then
    echo "$user_license" > "$LICENSE_FILE"
    echo -e "${GREEN}✅ License verified! Welcome.${NC}"
    sleep 1
  else
    echo -e "${RED}❌ Invalid license. Please get the correct one from Discord.${NC}"
    exit 1
  fi
fi

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
      echo -e "${GREEN}🔧 Installing PufferPanel...${NC}"
      bash <(curl -s https://raw.githubusercontent.com/subhanplays/hostingsetups/main/puffer-panel-install)

      echo -e "${GREEN}👤 Creating admin user...${NC}"
      sudo pufferpanel user add

      echo -e "${GREEN}🚀 Enabling and starting PufferPanel...${NC}"
      sudo systemctl enable --now pufferpanel

      echo -e "\n${CYAN}Made By Subhanplays${NC}"
      echo -e "${CYAN}Inspire by Jishnu Gamer${NC}"
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})"
      ;;
    2)
      echo -e "${GREEN}🚀 Running 24/7 script from GitHub...${NC}"
      wget -q https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py -O ~/24-7.py
      python3 ~/24-7.py

      echo -e "\n${CYAN}Made By Subhanplays${NC}"
      echo -e "${CYAN}Inspire by Jishnu Gamer${NC}"
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})"
      ;;
    3)
      echo -e "${GREEN}🌐 Downloading and running Playit tunnel...${NC}"
      wget -q https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64 -O ~/playit
      chmod +x ~/playit
      ~/playit

      echo -e "\n${CYAN}Made By Subhanplays${NC}"
      echo -e "${CYAN}Inspire by Jishnu Gamer${NC}"
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})"
      ;;
    0)
      echo -e "${RED}👋 Exiting...${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}❌ Invalid option. Try again.${NC}"
      sleep 2
      ;;
  esac
done
