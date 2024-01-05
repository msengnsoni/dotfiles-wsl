#!/bin/bash

# function 'echo_str'
function echo_str () {
  echo "---------------- Install $1 ---------------"
}

# Set SCRIPT_DIR
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install zsh
if [ ! -f "$HOME"/.zshrc ]; then
  echo_str "zsh"
  sudo apt -y install zsh
  chsh -s "$(which zsh)"
fi

# Install oh-my-zsh
if [ ! -f "$HOME"/.oh-my-zsh ]; then
  echo_str "oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
fi
