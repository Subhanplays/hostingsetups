#!/bin/bash

# Colors & styles
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
BG_BLUE='\033[44m'
RESET='\033[0m'

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

# Spinner animation for background jobs
spinner() {
  local pid=$!
  local delay=0.1
  local spinstr='|/-\'
  while kill -0 "$pid" 2>/dev/null; do
    for i in $(seq 0 3); do
      printf "\r${CYAN}${spinstr:$i:1} Loading...${RESET}"
      sleep $delay
    done
  done
  printf "\r${GREEN}✔ Done!       ${RESET}\n"
}

# Loading bar with percentage
progress_bar() {
  local duration=$1
  for ((i=0; i<=100; i+=5)); do
    printf "\r${CYAN}Progress: [%-20s] %d%%${RESET}" $(printf "%0.s#" $(seq 1 $((i/5)))) $i
    sleep $(bc -l <<< "$duration/20")
  done
  echo
}

print_header() {
  clear
  echo -e "${BG_BLUE}${BOLD}  Welcome to Subhan Installer  ${RESET}"
  echo
}

print_menu() {
  echo -e "${CYAN}╔════════════════════════╗${RESET}"
  echo -e "${CYAN}║${YELLOW} 1)${RESET} Install Panel           ${CYAN}║${RESET}"
  echo -e "${CYAN}║${YELLOW} 2)${RESET} Start 24/7 Script       ${CYAN}║${RESET}"
  echo -e "${CYAN}║${YELLOW} 3)${RESET} Create Tunnel (Playit)  ${CYAN}║${RESET}"
  echo -e "${CYAN}║${YELLOW} 0)${RESET} Exit                   ${CYAN}║${RESET}"
  echo -e "${CYAN}╚════════════════════════╝${RESET}"
  echo
  echo -ne "${GREEN}Choose option: ${RESET}"
}

print_credits() {
  echo -e "${CYAN}✅ Made By Subhanplays${RESET}"
  echo -e "${CYAN}✨ Inspire by Jishnu Gamer${RESET}"
}

# License validation with restart on fail
license_check() {
  print_header
  type_text "${CYAN}=============================="
  type_text "      🔐 License Required"
  type_text "==============================${RESET}"

  read -p "$(echo -e ${YELLOW}Enter your license key:${RESET} )" user_license

  if [[ "$user_license" != "$REQUIRED_LICENSE" ]]; then
    echo -ne "${RED}❌ Invalid license"
    for i in {1..3}; do
      echo -n "."
      sleep 0.4
    done
    echo -e " Please join our Discord to get a valid license.${RESET}"
    sleep 2
    exec "$0"  # restart script
  fi
}

# Set your license key here
REQUIRED_LICENSE="4358601972"

# Run license check before menu
license_check

# Main menu loop
while true; do
  print_header
  print_menu
  read -r option

  case $option in
    1)
      type_text "${GREEN}🔧 Installing PufferPanel...${RESET}" 0.01
      progress_bar 2

      bash <(curl -s https://raw.githubusercontent.com/subhanplays/hostingsetups/main/puffer-panel-install)

      type_text "${GREEN}👤 Creating admin user...${RESET}" 0.01
      sudo pufferpanel user add

      type_text "${GREEN}🚀 Enabling and starting PufferPanel...${RESET}" 0.01
      sudo systemctl enable --now pufferpanel

      echo
      print_credits
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${RESET})"
      ;;
    2)
      type_text "${GREEN}🚀 Running 24/7 script from GitHub...${RESET}" 0.01
      progress_bar 2

      wget -q https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py -O ~/24-7.py
      python3 ~/24-7.py

      echo
      print_credits
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${RESET})"
      ;;
    3)
      type_text "${GREEN}🌐 Downloading and running Playit tunnel...${RESET}" 0.01
      progress_bar 2

      wget -q https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64 -O ~/playit
      chmod +x ~/playit
      ~/playit

      echo
      print_credits
      read -p "$(echo -e ${YELLOW}Press Enter to continue...${RESET})"
      ;;
    0)
      echo -e "${RED}👋 Exiting...${RESET}"
      exit 0
      ;;
    *)
      echo -ne "${RED}❌ Invalid option"
      for i in {1..3}; do
        echo -n "."
        sleep 0.4
      done
      echo -e " Restarting menu...${RESET}"
      sleep 1
      ;;
  esac
done
