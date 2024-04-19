cd git

cp ./gitconfig ~/.gitconfig

cp ./gitignore ~/.gitignore
git config --global core.excludesfile ~/.gitignore

# Global templates / hookes
mkdir -p ~/.git-templates/hooks

cp ./git-templates/hooks/commit-msg ~/.git-templates/hooks/commit-msg
chmod +x ~/.git-templates/hooks/commit-msg

git config --global init.templatedir '~/.git-templates'

# GPG agent configuration on M1, M2, M3 chips
# @credit: https://quannhm.medium.com/signing-git-commits-on-mac-m1-a3d76170efce
cat <<EOF > ~/.gnupg/gpg.conf
use-agent
pinentry-mode loopback
EOF

cat <<EOF > ~/.gnupg/gpg-agent.conf
allow-preset-passphrase
allow-loopback-pinentry
EOF

gpgconf --launch gpg-agent


cd ..
echo "GIT: Global configuration is done"
