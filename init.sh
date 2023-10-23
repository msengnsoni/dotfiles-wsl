#!/bin/bash

# WSLの場合の判定
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then

    # Install brew
    echo "Install brew WSL"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

    # Set zsh
    sudo apt install zsh
    csh -s "$(which zsh)"
else
    exit 1
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

# Create synbolic link
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
for dotfile in "${SCRIPT_DIR}"/.bin/.??* ; do
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue
    ln -fnsv "$dotfile" "$HOME"
done

# Install from .Brewfile
brew bundle --global

# Check nvim 
if [ ! -f "$HOME"/.config/nvim ]; then
    # Create neovim synbolic link
    mkdir "$HOME"/.config/nvim
    ln -fnsv "$HOME"/dotfiles-wsl/.bin/.init.vim "$HOME"/.config/nvim/init.vim

    # Install vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # Install vim-comentary
    mkdir -p ~/.config/nvim/pack/tpope/start
    git clone https://tpope.io/vim/commentary.git "$HOME"/.vim/pack/tpope/start
    vim -u NONE -c "helptags commentary/doc" -c q
fi

# Install node
nvm install node
if [ ! -f "$HOME"/.nvm ]; then
    mkdir "$HOME"/.nvm
fi

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh
