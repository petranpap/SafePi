#!/bin/bash

echo "🔧 [SafePi Pi-hole Setup] Ξεκινάει η εγκατάσταση Pi-hole..."

# Update system
sudo apt update && sudo apt upgrade -y

# Install curl if not installed
sudo apt install -y curl

# Install Pi-hole
curl -sSL https://install.pi-hole.net | bash

echo "✅ [SafePi Pi-hole Setup] Ολοκληρώθηκε η εγκατάσταση!"
echo "👉 Άνοιξε http://pi.hole/admin για ρύθμιση DHCP και blocklists."
