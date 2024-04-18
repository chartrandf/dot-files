cd fonts

git clone --depth 1 --no-checkout https://github.com/adobe-fonts/source-code-pro.git
cd source-code-pro
git sparse-checkout init --cone
git sparse-checkout set OTF
git checkout release

cp OTF/*.otf ~/Library/Fonts
sudo atsutil databases -remove

cd ..
rm -rf source-code-pro

cd ..
echo "Font: Configuration is done"
