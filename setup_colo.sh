#!/bin/bash

TS=$(date +"%Y-%m-%d-%T")
BACKUP_DIR="${HOME}/.bashrc_backups/${TS}"
mkdir -p "${BACKUP_DIR}"

echo "Backup up existing .bashrc to ${BACKUP_DIR}..."
cp $HOME/.bashrc "${BACKUP_DIR}/"

REPO_ROOT="$HOME/dot-configs"
cp -v "${REPO_ROOT}/colo/.bashrc" $HOME/
cp -v -r "${REPO_ROOT}/colo/.bashrc.d/" $HOME/

echo "Done."
