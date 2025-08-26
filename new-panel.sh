#!/bin/bash
# V4Panel Installer with License Key
# Made by Subhan Zahid

# ===== Colors =====
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BG_BLUE='\033[44m'
BOLD='\033[1m'
RESET='\033[0m'

# ===== License Key (Change this) =====
REQUIRED_LICENSE="ABC-123-XYZ"

# ===== UI =====
print_header() {
  clear
  echo -e "${BG_BLUE}${BOLD}   Welcome to Subhan Installer   ${RESET}"
  echo
}

print_menu() {
  echo -e "${CYAN}╔═══════════════════════════════╗${RESET}"
  echo -e "${CYAN}║${YELLOW} 1)${RESET} Install Panel            ${CYAN}║${RESET}"
  echo -e "${CYAN}║${YELLOW} 2)${RESET} Start 24/7 Script        ${CYAN}║${RESET}"
  echo -e "${CYAN}║${YELLOW} 3)${RESET} Create Tunnel (Playit)   ${CYAN}║${RESET}"
  echo -e "${CYAN}║${YELLOW} 0)${RESET} Exit                    ${CYAN}║${RESET}"
  echo -e "${CYAN}╚═══════════════════════════════╝${RESET}"
  echo
  echo -ne "${GREEN}Choose option: ${RESET}"
}

print_credits() {
  echo -e "${CYAN}✅ Made By Subhanplays${RESET}"
  echo -e "${CYAN}✨ Inspired by Jishnu Gamer${RESET}"
}

# ===== License validation =====
license_check() {
  print_header
  echo -e "${CYAN}=============================="
  echo -e "      🔐 License Required"
  echo -e "==============================${RESET}"

  read -p "$(echo -e ${YELLOW}Enter your license key:${RESET} )" user_license

  if [[ "$user_license" != "$REQUIRED_LICENSE" ]]; then
    echo -e "${RED}❌ Invalid license. Please join our Discord to get a valid license.${RESET}"
    sleep 2
    exec "$0"  # restart script
  fi
  echo -e "${GREEN}✔ License Validated!${RESET}"
  sleep 1
}

# ===== Functions =====
install_panel() {
  print_header
  echo "📥 Installing V4Panel..."
  curl -sL https://deb.nodesource.com/setup_23.x | sudo bash -
  sudo apt-get install -y nodejs git zip unzip wget python3
  if [ ! -d "v4panel" ]; then
    git clone https://github.com/teryxlabs/v4panel
  fi
  cd v4panel || exit
  unzip -o panel.zip
  npm install
  npm run seed
  npm run createUser
  echo -e "${GREEN}✅ Panel Installed Successfully${RESET}"
}

start_24_7() {
  print_header
  echo "⚡ Starting 24/7 Script..."
  wget -q https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py -O ~/24-7.py
  python3 ~/24-7.py
}

create_tunnel() {
  print_header
  echo "🌐 Setting up Playit Tunnel..."
  wget -O playit-linux-amd64 https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64
  chmod +x playit-linux-amd64
  ./playit-linux-amd64
}

# ===== Main =====
license_check

while true; do
  print_header
  print_menu
  read -r choice
  case $choice in
    1) install_panel ;;
    2) start_24_7 ;;
    3) create_tunnel ;;
    0) print_credits; exit 0 ;;
    *) echo -e "${RED}❌ Invalid option!${RESET}" ;;
  esac
  echo -e "\nPress Enter to continue..."
  read -r
done

