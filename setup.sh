
#!/bin/bash

# Define URLs for fish config and neovim config
FISH_CONFIG_URL="YOUR_FISH_CONFIG_URL"
NEOVIM_CONFIG_URL="YOUR_NEOVIM_CONFIG_URL"

echo "[+] Updating system and installing dependencies..."
sudo apt update && sudo apt upgrade -y

# Install essential tools
echo "[+] Installing necessary tools..."
sudo apt install -y fish neovim fzf tmux xclip wl-clipboard git curl wget sed unzip

# Install fisher (plugin manager for fish)
echo "[+] Installing Fisher..."
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Install Fish plugins
echo "[+] Installing Fish plugins..."
fisher install jethrokuan/z # Auto jump directories

# Ensure Fish shell is default
if [ "$SHELL" != "$(which fish)" ]; then
    echo "[+] Setting Fish as the default shell..."
    chsh -s $(which fish)
fi

# Backup existing Fish config
echo "[+] Backing up existing Fish config..."
mkdir -p ~/.config/backup
[ -d ~/.config/fish ] && mv ~/.config/fish ~/.config/backup/fish-$(date +%s)

# Setup Fish config
echo "[+] Downloading and setting up Fish config..."
mkdir -p ~/.config/fish
curl -sL $FISH_CONFIG_URL -o fish-config.zip
unzip fish-config.zip -d ~/.config
rm fish-config.zip

# Backup existing Neovim config
echo "[+] Backing up existing Neovim config..."
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/backup/nvim-$(date +%s)

# Setup Neovim config
echo "[+] Downloading and setting up Neovim config..."
mkdir -p ~/.config/nvim
curl -sL $NEOVIM_CONFIG_URL -o nvim-config.zip
unzip nvim-config.zip -d ~/.config
rm nvim-config.zip

# Ensure system PATH is updated
echo "[+] Ensuring PATH is updated..."
fish -c "set -U fish_user_paths $fish_user_paths ~/.local/bin ~/go/bin"

echo "[+] Setup complete! Restart your terminal or run 'exec fish' to apply changes."
