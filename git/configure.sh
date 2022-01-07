cd git

cp ./gitconfig ~/.gitconfig
cp ./gitignore ~/.gitignore

# Global templates / hookes
mkdir -p ~/.git-templates/hooks

cp ./git-templates/hooks/commit-msg ~/.git-templates/hooks/commit-msg
chmod +x ~/.git-templates/hooks/commit-msg

git config --global init.templatedir '~/.git-templates'

cd ..
echo "GIT: Global configuration is done"