# Server Panel Installer Collection

Welcome to the Server Panel Installer Collection!  
This repository provides quick and easy installation commands for popular game server management panels like **PufferPanel** and **Skyport Panel**. These panels help you efficiently manage Minecraft and other game servers.

---

## Available Panels & Installation Commands

### 1. PufferPanel

A popular open-source game server management panel with a clean interface.

**Install using:**

```bash
bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/Install.sh)
2. Skyport Panel
A modern Minecraft server panel with advanced features and a smooth UI.

Install using:

bash
Copy
Edit
curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/skyport-install.sh | bash
Usage Instructions
Run the above commands on a Linux server (Ubuntu/Debian recommended).

Execute the commands as root or with sudo to ensure permissions.

The scripts will automate dependency installation, repository cloning, and panel startup.

Once installed, access the panels using your server's IP address and configured ports.

Managing Skyport Panel with PM2
Skyport uses PM2 to manage its Node.js process. Useful PM2 commands:

bash
Copy
Edit
pm2 status        # Show running processes
pm2 restart index # Restart Skyport panel
pm2 stop index    # Stop Skyport panel
pm2 logs index    # View Skyport logs
Troubleshooting
Verify you run the install scripts as root or using sudo.

Ensure your server has internet access and is up-to-date.

Check PM2 logs for any runtime errors (pm2 logs index).

For permission errors, verify your user privileges.

Restart the server or panel if needed.

Notes
Installation scripts assume a fresh or clean server environment.

Skyport installation directory defaults to skyport; you can modify the script to change this.

Node.js version 20.x is used in installations via NodeSource.

Author
Subhan Zahid aka Subhanplays
GitHub: https://github.com/Subhanplays

License
Scripts and materials are provided "as-is" without warranty. Use at your own risk.

pgsql
Copy
Edit

---

If you still see “yaml Copy Edit” or something else inside your README file after saving, it’s likely due to the editor or website where you’re pasting — make sure you’re pasting into a plain text editor or GitHub’s raw file editor without UI noise.

Want me to help you with how to upload or edit the README cleanly?
