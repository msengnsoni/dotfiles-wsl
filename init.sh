#!/bin/bash

# Set SCRIPT_DIR
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check WSL or else
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    if [ ! -f /home/linuxbrew/.linuxbrew ]; then
        # Install brew
        echo "Install brew WSL"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

        # Set zsh
        sudo apt install zsh
        csh -s "$(which zsh)"

        # Install from .Brewfile
        brew bundle --global
   fi
else
    exit 1
fi

# Install oh-my-zsh
if [ ! -f "$HOME"/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
fi

# Create synbolic link
for dotfile in "${SCRIPT_DIR}"/.bin/.??* ; do
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.bin/.init.vim" ]] && continue
    ln -fnsv "$dotfile" "$HOME"
done

# Check nvim 
if [ ! -f "$HOME"/.config/nvim ]; then
    # Create neovim synbolic link
    mkdir "$HOME"/.config/nvim
    ln -fnsv "$SCRIPT_DIR"/.bin/.init.vim "$HOME"/.config/nvim/init.vim

    # Install vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # Install vim-comentary
    mkdir -p "$HOME"/.config/nvim/pack/tpope/start
    git clone https://tpope.io/vim/commentary.git "$HOME"/.vim/pack/tpope/start
    vim -u NONE -c "helptags commentary/doc" -c q
fi

# Install node
if [ ! -f "$HOME"/.nvm ]; then
    nvm install node
    mkdir "$HOME"/.nvm
fi

# Install Docker
if [ ! -f /lib/systemd/system/docker.service ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
fi
