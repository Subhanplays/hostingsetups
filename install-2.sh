#!/bin/bash

clear
echo "==============================="
echo " Skyport Installer Menu"
echo "==============================="
echo "1) Install Panel"
echo "2) Install Wings / Node"
echo "3) Install Both"
echo "4) Exit"
echo "==============================="
read -rp "Choose an option [1-4]: " choice

install_panel() {
  echo "Installing Panel..."
  bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/skyport-install.sh)
  echo "Panel installation completed."
}

install_wings() {
  echo "Installing Wings / Node..."
  bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/wing.sh)
  echo "Changing directory to skyportd..."
  cd skyportd || { echo "Directory 'skyportd' not found!"; exit 1; }
  echo "Please paste your node configuration now (edit files as needed)."
  echo "After configuration, start node with: pm2 start ."
}

case $choice in
  1)
    install_panel
    ;;
  2)
    install_wings
    ;;
  3)
    install_panel
    install_wings
    ;;
  4)
    echo "Exiting installer."
    exit 0
    ;;
  *)
    echo "Invalid option. Exiting."
    exit 1
    ;;
esac
