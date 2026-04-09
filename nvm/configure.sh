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

read -p "Do you want to install Node LTS + pnpm? (Y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
  nvm install --lts
  corepack enable pnpm
  echo "Node LTS + pnpm installed"
fi

if type pnpm &> /dev/null; then
  pnpm config set commit-hooks false --global
  pnpm config set tag-version-prefix "" --global
  echo "pnpm: global config set"
fi

cd ..
echo "NVM: Configuration is done"
