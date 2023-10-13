#!/bin/bash

echo "**** install code-server ****" &&
  mkdir -p ~/vscode/app/code-server &&
  mkdir -p ~/vscode/tmp &&
  curl -o \
    ~/vscode/tmp/code-server.tar.gz -L \
    "https://github.com/coder/code-server/releases/download/v4.17.1/code-server-4.17.1-linux-amd64.tar.gz" &&
  tar xf \
    ~/vscode/tmp/code-server.tar.gz -C \
    ~/vscode/app/code-server/ --strip-components=1 &&
  echo "**** clean up ****" &&
  rm -rf \
    ~/vscode/tmp/*

echo "Starting VSCode Server..."

exec ~/vscode/app/code-server/bin/code-server --host 0.0.0.0 --port 7860
