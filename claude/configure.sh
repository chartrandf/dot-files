cd claude

mkdir -p ~/.claude/{rules,agents,commands,skills}

# Add Claude env config to zshrc if not already present
grep -q "CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR" ~/.zshrc || echo 'export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=true # Keep Claude in the right directory' >> ~/.zshrc

cd ..
echo "CLAUDE: Global configuration is done"
