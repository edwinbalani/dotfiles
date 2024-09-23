nvim_confdir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [ -e "$nvim_confdir" ]; then
    echo "$nvim_confdir exists - not touching it."
else
    echo "Checking out Neovim config..."
    git clone --depth=1 https://git.dom0.net/ebb/neovim.git "$nvim_confdir"
fi
