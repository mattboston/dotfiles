#!/bin/bash

set -e # exit on error

USE_CASE=$1

if [ -z "$USE_CASE" ]; then
  USE_CASE="home"
  echo "Using default use case: $USE_CASE"
else
  if [ "$USE_CASE" != "home" ] && [ "$USE_CASE" != "work" ]; then
    echo "Invalid use case: $USE_CASE"
    exit 1
  fi
  USE_CASE=$1
  echo "Using custom use case: $USE_CASE"
fi

if [ "$(command -v curl)" ]; then
  echo "Using curl to download .env_${USE_CASE} file"
  curl -fsSL https://raw.githubusercontent.com/mattboston/dotfiles/refs/heads/main/.env_${USE_CASE} -o .env_${USE_CASE}
  # curl -fsSL https://raw.githubusercontent.com/mattboston/dotfiles/refs/heads/main/Brewfile-${USE_CASE} -o Brewfile-${USE_CASE}
else
  echo "You must have curl installed." >&2
  exit 1
fi

source .env_${USE_CASE}
bin_dir="$HOME/bin"

# Set git commit settings. You'll need these to update this repo.
git config --global user.email "${GITHUB_EMAIL}"
git config --global user.name "${GITHUB_NAME}"

# Check that we have curl or wget
# if [[ ! "$(command -v curl)" || ! "$(command -v wget)" ]]; then
if [[ ! "$(command -v curl)" ]]; then
  # echo "To install, you must have curl or wget installed." >&2
  echo "To install, you must have curl installed." >&2
  # add some code to try installing curl and/or wget based on OS
  exit 1
fi

# if [[ "$OSTYPE" =~ ^darwin && ! "$(xcode-select -p 1>/dev/null;echo $?)" ]]; then
#     echo "MacOS"
#     xcode-select --install
# fi

if [ ! "$(command -v brew)" ]; then
  if [ "$(command -v curl)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "To install brew, you must have curl installed." >&2
    exit 1
  fi
fi

if [ ! "$(command -v chezmoi)" ]; then
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://git.io/chezmoi)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
# script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# exec: replace current process with chezmoi init
# exec "$chezmoi" init --apply "--source=$script_dir"
chezmoi init --apply ${GITHUB_USERNAME}

brew bundle install --file=~/Brewfile-${USE_CASE}

# Stop here until I figure out what I want to do on other OSes
exit 0

if [[ "${OSTYPE}" =~ ^darwin || "${OSTYPE}" =~ ^linux ]]; then

fi


if [[ "${OSTYPE}" =~ ^linux ]]; then
    echo "Linux"
    bin_dir='~/bin'
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

