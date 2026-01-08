#!/bin/bash

clear

echo "===================================="
echo "      Welcome to CSD83 x SHIM"
echo "The ultimate tool for csd83 devices"
echo "===================================="
echo

if ! sudo -v; then
    echo "Sudo required. Exiting."
    exit 1
fi

echo
echo "1) Get Started"
echo "2) For IT"
echo
read -p "Select an option: " MAIN_CHOICE


if [[ "$MAIN_CHOICE" == "2" ]]; then
    clear
    echo "===================================="
    echo "   For my beloved IT people"
    echo "===================================="
    echo
    echo "Imagine being so ahh at managing these chromebooks that a"
    echo "13 year old kid made a simple script that fully bypasses all of"
    echo "Your dummy dumb dumb systems in under 10 minutes :rofl:"
    echo "You must really suck at your job lmao."
    echo "AND not to mention this tool is made in BASH, the easiest lanuage ever!!"
    echo "Not to mention this is in beta and still beats your entire YEARS of security."
    echo "Not to mention this thing is under 215 lines of code and still beats your entire YEARS of security."
    echo "Hope yall love your jobs because this is only the beginning :D"
    echo
    read -p "Press Enter to exit..."
    exit 0
fi



if [[ "$MAIN_CHOICE" != "1" ]]; then
    echo "Invalid option. Exiting."
    exit 1
fi


NET_CHOICE=0
DE_CHOICE=0
GAME_CHOICES=()
APP_CHOICES=()

echo
echo "Select network bypass option:"
echo "1) None"
echo "2) Cloudflare WARP (VPN)"
echo "3) Tor (Proxy)"
read -p "Enter choice: " NET_CHOICE

echo
echo "Select Desktop Environment:"
echo "1) GNOME (heavy on RAM)"
echo "2) KDE (medium on RAM)"
echo "3) XFCE (light on RAM)"
read -p "Enter choice: " DE_CHOICE

echo
echo "Select games to install (space separated):"
echo "1) Prism Launcher (Minecraft)"
echo "2) Sober (Roblox)"
echo "3) Steam"
echo "4) SuperTuxKart"
read -a GAME_CHOICES

echo
echo "Select apps to install (space separated):"
echo "1) VS Code"
echo "2) Helix"
echo "3) GCC"
echo "4) Git"
echo "5) Neovim"
read -a APP_CHOICES


clear
echo "===================================="
echo " Executing CSD83 x SHIM Setup"
echo "===================================="
echo

echo "[1/5] Updating system packages..."
sudo apt update && sudo apt upgrade -y

# -----------------------------
# NETWORK
# -----------------------------

case "$NET_CHOICE" in
    2)
        echo "[2/5] Installing Cloudflare WARP..."
        sudo apt install -y curl gnupg lsb-release
        curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg
        echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
        sudo apt update
        sudo apt install -y cloudflare-warp
        sudo warp-cli register
        sudo warp-cli set-mode warp
        sudo warp-cli connect
        ;;
    3)
        echo "[2/5] Installing Tor..."
        sudo apt install -y tor torsocks
        sudo systemctl enable tor
        sudo systemctl start tor
        ;;
esac


case "$DE_CHOICE" in
    1)
        echo "[3/5] Installing GNOME..."
        sudo apt install -y gnome gdm3
        ;;
    2)
        echo "[3/5] Installing KDE..."
        sudo apt install -y kde-standard sddm
        ;;
    3)
        echo "[3/5] Installing XFCE..."
        sudo apt install -y xfce4 xfce4-goodies lightdm
        ;;
esac


echo "[4/5] Installing games..."
for choice in "${GAME_CHOICES[@]}"; do
    case "$choice" in
        1)
            sudo apt install -y flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak install -y flathub org.prismlauncher.PrismLauncher
            ;;
        2)
            echo "Sober install placeholder"
            ;;
        3)
            sudo dpkg --add-architecture i386
            sudo apt update
            sudo apt install -y steam
            ;;
        4)
            sudo apt install -y supertuxkart
            ;;
    esac
done


echo "[5/5] Installing apps..."
for choice in "${APP_CHOICES[@]}"; do
    case "$choice" in
        1)
            sudo apt install -y wget gpg
            wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/ms.gpg > /dev/null
            echo "deb [arch=amd64 signed-by=/usr/share/keyrings/ms.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            sudo apt update
            sudo apt install -y code
            ;;
        2)
            sudo apt install -y helix
            ;;
        3)
            sudo apt install -y build-essential
            ;;
        4)
            sudo apt install -y git
            ;;
        5)
            sudo apt install -y neovim
            ;;
    esac
done

echo
echo "===================================="
echo "    CSD83 x SHIM setup complete"
echo " Please reboot back into shimboot"
echo "===================================="
