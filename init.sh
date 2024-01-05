#!/bin/bash

# function 'echo_str'
function echo_str () {
  echo "---------------- Install $1 ---------------"
}

# Set SCRIPT_DIR
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Check WSL or else
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  # Install brew
  echo_str "brew"
  if [ ! -f /home/linuxbrew/.linuxbrew ]; then
    echo "Install brew WSL"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Install from .Brewfile
    echo_str "from .Brewfile"
    brew bundle --global --file "${SCRIPT_DIR}/.bin/.Brewfile"
  fi
else
  exit 1
fi

# Create synbolic link
for dotfile in "${SCRIPT_DIR}"/.bin/.??* ; do
  [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
  [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
  [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue
  [[ "$dotfile" == "${SCRIPT_DIR}/.bin/.init.vim" ]] && continue
  ln -fnsv "$dotfile" "$HOME"
done

# Install zsh
if [ ! -f "$HOME"/.zshrc ]; then
  echo_str "zsh"
  sudo apt -y install zsh
  chsh -s "$(which zsh)"
fi

# Check nvim 
if [ ! -d "$HOME"/.config/nvim ]; then
  # Create neovim synbolic link
  mkdir "$HOME"/.config/nvim
  ln -fnsv "$SCRIPT_DIR"/.bin/.init.vim "$HOME"/.config/nvim/init.vim

  # Install vim-plug
  echo_str "vim-plug"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  # Install vim-comentary
  echo_str vim-comentary
  mkdir -p "$HOME"/.config/nvim/pack/tpope/start
  git clone https://tpope.io/vim/commentary.git "$HOME"/.vim/pack/tpope/start
  vim -u NONE -c "helptags commentary/doc" -c q
fi

# Install node
if [ ! -d "$HOME"/.nvm ]; then
  echo_str "node"
  nvm install node
  mkdir "$HOME"/.nvm
fi

# Install Docker
if [ ! -f /lib/systemd/system/docker.service ]; then
  echo_str "Docker"
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
fi

# Install ja_JP language pack
if [ ! -d /sur/share/doc/language-pack-ja ]; then
  echo_str "ja_JP language pack"
  sudo apt-get -y install language-pack-ja
fi
