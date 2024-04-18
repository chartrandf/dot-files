cd nvm

if type nvm &> /dev/null; then
  echo "NVM already installed"
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  rm install.sh || true
  
  # ZSH auto load from .nvmrc
  cp load-nvmrc.sh ~/scripts
  echo "source ~/scripts/load-nvmrc.sh" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

cd ..
echo "NVM: Configuration is done"
