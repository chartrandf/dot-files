cd oh-my-zsh

if command -v "zsh" >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

cp themes/lambda.zsh-theme ~/.oh-my-zsh/themes
mv ~/.zshrc ~/.zshrc-default
cp zshrc ~/.zshrc

cd ..
echo "OH-MY-ZSH: Configuration is done"
