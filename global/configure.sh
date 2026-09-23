cd global

cp biome/biome.json ~/
cp -R zcripts ~/
mkdir -p ~/.local/bin
cp zcripts/quick-proxy.sh ~/.local/bin/quick-proxy
cp ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty

# Karabiner-Elements
mkdir -p ~/.config/karabiner/assets/complex_modifications
cp karabiner-elements/*.json ~/.config/karabiner/assets/complex_modifications/

# mitmproxy
mkdir -p ~/.mitmproxy
cp mitmproxy/config.yaml ~/.mitmproxy/

cd ..
echo "Global Setup: Configuration is done"
