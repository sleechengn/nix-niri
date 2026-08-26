{ pkgs }:

pkgs.writeShellScriptBin "t" ''
  #!/usr/bin/env bash
  set -ex
  if ! command -v tmux > /dev/null; then
    echo "tmux not install"
    exit 2
  fi
  if ! command -v fish > /dev/null; then
    echo "fish not install"
    exit 6
  fi
  if [ "$(tmux ls|grep '^default.*')" ]; then
    tmux a -t default
  else
    tmux new -s default
  fi
''