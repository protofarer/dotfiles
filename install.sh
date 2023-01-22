#!/bin/sh

set -e  # -e: exit on error

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS https://chezmoi.io/get)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://chezmoi.io/get)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get this script's dir: https://stackoverflow.com/a/29834779/12156188
# script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
#
# improvement to above per same page
# -P for: resolve the resulting directory path to its ultimate target in case the directory and/or its components are symlinks
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply "--source=$script_dir"

# alternatively, bootstrap with only git and following command (chezmoi init+apply for specified dotfiles repo)
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply protofarer/dotfilez.git

# Alternate for debugging
# exec /dotfilez/chezmoi init --apply "--source=$script_dir"
