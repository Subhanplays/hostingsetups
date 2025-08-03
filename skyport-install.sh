#!/bin/bash

# ===============================
#      Skyport Installer Script
# ===============================

# ASCII Art Banner
ascii_art="
  [ ... ASCII Art Same As Before ... ]
"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions for colorful output
print_info() { echo -e "${CYAN}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Clear screen and banner
clear
echo -e "${CYAN}${ascii_art}${NC}"
echo -e "${YELLOW}Welcome to the Skyport Installer!${NC}\n"

# License Key Check
VALID_LICENSE_KEY="4358601972"
read -p "Enter your license key: " input_key

if [[ "$input_key" != "$VALID_LICENSE_KEY" ]]; then
    print_error "Invalid license key. Installation aborted."
    exit 1
fi

print_success "License key verified."

# Root check
if [[ $EUID -ne 0 ]]; then
    print_error "Please run this script as root (sudo)."
    exit 1
fi

print_info "Updating package lists..."
apt update -y

print_info "Installing dependencies: curl, git, software-properties-common..."
apt install -y curl git software-properties-common

print_info "Adding Node.js 20.x repo..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

print_info "Installing Node.js..."
apt install -y nodejs

print_success "Dependencies installed."

print_info "Creating installation directory..."
INSTALL_DIR="skyport"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || { print_error "Failed to enter directory $INSTALL_DIR"; exit 1; }

print_info "Cloning Skyport repository..."
git clone https://github.com/achul123/panel5.git .

print_info "Installing Node.js packages..."
npm install

print_success "Setup completed!"

print_info "Running database seed and user creation scripts..."
npm run seed
npm run createUser

print_info "Installing PM2 process manager globally..."
npm install -g pm2

print_info "Starting Skyport with PM2..."
pm2 start index.js
pm2 save

print_success "Skyport is running on port 3001!"

echo -e "\n${YELLOW}Manage Skyport process with PM2 commands:${NC}"
echo -e "  ${BLUE}pm2 status${NC}         - show running processes"
echo -e "  ${BLUE}pm2 restart index${NC}   - restart Skyport"
echo -e "  ${BLUE}pm2 stop index${NC}      - stop Skyport\n"

print_info "Installation finished. Enjoy your Skyport panel!"

