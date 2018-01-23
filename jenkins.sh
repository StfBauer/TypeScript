#!/usr/bin/env bash

# Set up NVM
export NVM_DIR="/home/dotnet-bot/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install $1

npm uninstall typescript --no-save
npm uninstall tslint --no-save
npm install

# Node 6 uses an older version of npm that does not symlink a package with a "file:" reference
if [ "$1" = "6" ]; then
    npm uninstall typemock @typescript/vfs @typescript/vfs-path @typescript/vfs-core @typescript/vfs-errors --no-save;
    ln -s node_modules/typemock scripts/typemock;
    ln -s node_modules/@typescript/vfs-errors scripts/vfs-errors;
    ln -s node_modules/@typescript/vfs-core scripts/vfs-core;
    ln -s node_modules/@typescript/vfs-path scripts/vfs-path;
    ln -s node_modules/@typescript/vfs scripts/vfs;
    npm run build:private-packages;
fi

npm update
npm test
