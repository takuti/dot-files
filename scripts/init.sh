#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
  PLATFORM='mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  PLATFORM='linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

export PLATFORM

if [ -z "${DOTPATH:-}" ]; then
  DOTPATH=$(pwd -P); export DOTPATH
fi

sudo -v

bash "$DOTPATH"/scripts/zsh.sh
bash "$DOTPATH"/scripts/vim.sh
