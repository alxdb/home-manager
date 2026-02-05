#!/usr/bin/env bash

set -e
pushd $HOME/.config/home-manager/ > /dev/null
trap 'popd > /dev/null' EXIT

nvim home.nix

if [[ `git status --porcelain` ]]; then
  git add -i
  if [[ `git status --porcelain` ]]; then
    read -p "Apply uncommitted changes? " apply_uncommitted_changes
    case $apply_uncommitted_changes in
      [Yy]* ) home-manager switch;;
      *     ) echo "Not applying uncommitted changes";
    esac
  else
    home-manager switch
  fi
fi

