#!/bin/bash

echo "🔧 [SafePi Installer] Ξεκινάει η αυτόματη εγκατάσταση..."

# Install git if not installed
sudo apt update
sudo apt install -y git

# Clone SafePi repository
cd ~
git clone https://github.com/petranpap/SafePi/
cd safe-pi

# Make scripts executable
chmod +x setup_project.sh
chmod +x setup_pihole.sh

# Run setup_project.sh
./setup_project.sh

# Run setup_pihole.sh
./setup_pihole.sh

echo "✅ [SafePi Installer] Η εγκατάσταση ολοκληρώθηκε πλήρως!"
echo "👉 Τώρα μπορείς να ξεκινήσεις το SafePi και να ρυθμίσεις το Pi-hole DHCP."
