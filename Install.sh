#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
reset='\033[0m'

display_main_menu() {
    echo -e "${red}Made by play451${reset}"
    echo -e "${green}Please note that I am not affiliated with any of these projects, I just made this for fun.${reset}"
    echo "What do you want to install?"
    echo "1. Skyport"
    echo "2. Skyportd"
    echo "3. Palpod"
    echo "4. Exit"
    read -p "Enter your choice: " choice
    return $choice
}

display_installation_method_menu() {
    echo "How do you want to install $1?"
    echo "1. Localhost"
    echo "2. With Cloudflare tunnels"
    echo "3. With ngrok"
    echo "4. Exit"
    read -p "Enter your choice: " method_choice
    return $method_choice
}

while true; do
    display_main_menu
    case $choice in
        1)
            display_installation_method_menu "Skyport"
            case $method_choice in
                1)
                    echo "Installing Skyport on localhost..."
                    sudo apt install git sudo wget -y
                    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
                    source ~/.bashrc
                    nvm install node
                    git clone https://github.com/skyportlabs/panel
                    cd panel
                    npm install
                    npm run seed
                    npm run createUser
                    node .
                    echo "Skyport is done installing. Go to https://localhost:3001"
                    ;;
                2)
                    echo "Installing Skyport with Cloudflare tunnels..."
                    sudo apt install git sudo wget curl -y
                    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
                    source ~/.bashrc
                    nvm install node
                    git clone https://github.com/skyportlabs/panel
                    cd panel
                    npm install
                    npm install pm2 -g
                    npm run seed
                    npm run createUser
                    pm2 start index.js
                    echo "Now installing Cloudflare tunnels"
                    curl -L https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb --output cloudflared.deb
                    sudo dpkg -i cloudflared.deb
                    cloudflared tunnel login
                    cloudflared tunnel create skyport1
                    echo "I dont know how to automate this part so please go to https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/create-local-tunnel/"
                    ;;
                3)
                    echo "Installing Skyport with ngrok..."
                    ;;
                4)
                    exit
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        2)
            display_installation_method_menu "Skyportd"
            case $method_choice in
                1)
                    echo "Installing Skyportd on localhost..."
                    ;;
                2)
                    echo "Installing Skyportd with Cloudflare tunnels..."
                    ;;
                3)
                    echo "Installing Skyportd with ngrok..."
                    ;;
                4)
                    exit
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        3)
            display_installation_method_menu "Palpod"
            case $method_choice in
                1)
                    echo "Installing Palpod on localhost..."
                    ;;
                2)
                    echo "Installing Palpod with Cloudflare tunnels..."
                    ;;
                3)
                    echo "Installing Palpod with ngrok..."
                    ;;
                4)
                    exit
                    ;;
                *)
                    echo "Invalid choice"
                    ;;
            esac
            ;;
        4)
            exit
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
done
