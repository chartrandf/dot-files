RESTORE='\033[0m'
GREEN='\033[00;32m'

commands=(
    "./osx/configure.sh"
    "./oh-my-zsh/configure.sh"
    "./brew/configure.sh"
    "./git/configure.sh"
    "./fonts/configure.sh"
    "./nvm/configure.sh"
    "./vim/configure.sh"
    "./global/configure.sh"
)

for i in "${!commands[@]}"; do
    echo "\n👉 ${GREEN}${commands[i]}${RESTORE}"
    read -p "Do you want to run this script? (Y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]
    then
        echo "No, skipping..."
    else
        sh "${commands[i]}"
    fi
done


sh ./manual-steps/configure.sh
