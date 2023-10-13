#!/bin/bash

  echo "**** install openvscode-server ****" &&
  if [ -z ${CODE_RELEASE+x} ]; then
    CODE_RELEASE=$(curl -sX GET "https://api.github.com/repos/gitpod-io/openvscode-server/releases/latest" |
      awk '/tag_name/{print $4;exit}' FS='[""]' |
      sed 's|^openvscode-server-v||')
  fi &&
  mkdir -p ~/vscode/app/openvscode-server &&
  mkdir -p ~/vscode/tmp &&
  curl -o \
    ~/vscode/tmp/openvscode-server.tar.gz -L \
    "https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v${CODE_RELEASE}/openvscode-server-v${CODE_RELEASE}-linux-x64.tar.gz" &&
  tar xf \
    ~/vscode/tmp/openvscode-server.tar.gz -C \
    ~/vscode/app/openvscode-server/ --strip-components=1 &&
  echo "**** clean up ****" &&
  rm -rf \
    ~/vscode/tmp/*

echo "Starting VSCode Server..."

exec ~/vscode/app/openvscode-server/bin/openvscode-server --host 0.0.0.0 --port 7860 --auth password --without-connection-token \"${@}\" --
