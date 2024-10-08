#!/bin/bash

# set -e # exit on error

sudo echo

USE_ENV=$1

if [ -z "$USE_ENV" ]; then
  USE_ENV="home"
  echo "Using default ENV case: $USE_ENV"
else
  if [ "$USE_ENV" != "home" ] && [ "$USE_ENV" != "work" ]; then
    echo "Invalid ENV case: $USE_ENV"
    exit 1
  fi
  echo "Using custom ENV case: $USE_ENV"
fi

# Check that we have curl or wget
# if [[ ! "$(command -v curl)" || ! "$(command -v wget)" ]]; then
if [[ ! "$(command -v curl)" ]]; then
  # echo "To install, you must have curl or wget installed." >&2
  echo "To install, you must have curl installed." >&2
  # add some code to try installing curl and/or wget based on OS
  exit 1
fi

if [ "$(command -v curl)" ]; then
  echo "Using curl to download .env_${USE_ENV} and Brewfile-${USE_ENV} file"
  curl -fsSL https://raw.githubusercontent.com/mattboston/dotfiles/refs/heads/main/.env_${USE_ENV} -o .env_${USE_ENV}
  curl -fsSL https://raw.githubusercontent.com/mattboston/dotfiles/refs/heads/main/Brewfile-${USE_ENV} -o Brewfile-${USE_ENV}
else
  echo "You must have curl installed." >&2
  exit 1
fi

source .env_${USE_ENV}
BIN_DIR="$HOME/bin"
CODE_DIR="$HOME/Development"
echo "Creating directories: ${BIN_DIR} ${CODE_DIR}"
mkdir -p ${BIN_DIR} ${CODE_DIR}

if [ ! "$(command -v brew)" ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash -s
  # brew install mas
  echo >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ ! -d "~/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# if [[ "$OSTYPE" =~ ^darwin && ! "$(xcode-select -p 1>/dev/null;echo $?)" ]]; then
# # if [[ "$OSTYPE" =~ ^darwin ]]; then
#   if [ ! "$(command -v xcode-select)" ]; then
#     # echo "MacOS"
#     echo "Installing xcode"
#     # sudo xcode-select --install
#     xcode-select --install
# fi

# Set git commit settings. You'll need these to update this repo.
echo "Setting git config"
git config --global user.email "${GITHUB_EMAIL}"
git config --global user.name "${GITHUB_NAME}"

if [ ! -d "${$HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "${$HOME}/.oh-my-zsh/custom/themes/powerlevel10k does not exist. Cloning repo..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [ ! "$(command -v chezmoi)" ]; then
  brew install chezmoi
fi
chezmoi=/opt/homebrew/bin/chezmoi
chezmoi init --apply ${GITHUB_USERNAME}

brew bundle install --file=~/Brewfile-${USE_ENV}

~/.local/share/chezmoi/defaults.sh

# Stop here until I figure out what I want to do on other OSes
exit 0

if [[ "${OSTYPE}" =~ ^darwin || "${OSTYPE}" =~ ^linux ]]; then

fi


if [[ "${OSTYPE}" =~ ^linux ]]; then
    echo "Linux"
    BIN_DIR='~/bin'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    elif [ -f /etc/debian_version ]; then
        # Older Debian/Ubuntu/etc.
        OS=Debian
        VER=$(cat /etc/debian_version)
    elif [ -f /etc/SuSe-release ]; then
        # Older SuSE/etc.
        echo "Add stuff here"
    elif [ -f /etc/redhat-release ]; then
        # Older Red Hat, CentOS, etc.
        echo "Add stuff here"
    else
        # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
        OS=$(uname -s)
        VER=$(uname -r)
    fi

    echo "${OS}"
    echo "${VER}"

    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fi

# No way to test this yet
if [[ "${OSTYPE}" =~ ^windows ]]; then
    echo "Windows"
fi

