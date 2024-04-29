cd vim

mkdir -p ~/.vim/colors
cp colors/*.vim ~/.vim/colors

[ -f ~/.vimrc ] && cp -p ~/.vimrc ~/.vrimrc-bk
cp vimrc ~/.vimrc

cd ..
echo "VIM: Global configuration is done"
