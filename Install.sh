#!/bin/bash

while true; do
  clear
  echo "=============================="
  echo "        🧰 Main Menu"
  echo "=============================="
  echo "1) Install Panel"
  echo "2) Start 24/7 Script"
  echo "3) Create Tunnel (Playit)"
  echo "0) Exit"
  echo "=============================="
  read -p "Choose an option: " option

  case $option in
    1)
      echo "🔧 Installing PufferPanel..."
      bash <(curl -s https://raw.githubusercontent.com/subhanplays/hostingsetups/main/puffer-panel-install)

      echo "👤 Creating admin user..."
      sudo pufferpanel user add

      echo "🚀 Enabling and starting PufferPanel..."
      sudo systemctl enable --now pufferpanel

      echo "✅ PufferPanel installation complete!"
      read -p "Press Enter to continue..."
      ;;
    2)
      echo "🚀 Running 24/7 script from GitHub..."
      # Download and run latest version of your 24/7 script
      wget -q https://raw.githubusercontent.com/Subhanplays/24-7/main/24-7.py -O ~/24-7.py
      python3 ~/24-7.py
      read -p "Press Enter to continue..."
      ;;
    3)
      echo "🌐 Creating Playit tunnel..."
      # Replace this with your actual playit command/path
      ~/playit
      read -p "Press Enter after checking the tunnel IP..."
      ;;
    0)
      echo "👋 Exiting..."
      exit 0
      ;;
    *)
      echo "❌ Invalid option. Try again."
      sleep 2
      ;;
  esac
done
