#!/bin/bash

REPO_URL="https://github.com/Dmitriy-Garfild/shvirtd-example-python.git"  
DEST_DIR="/opt/shvirtd-example-python"  
# Скачивание репозитория
if [ ! -d "$DEST_DIR" ]; then
  echo "Клонируем репозиторий в $DEST_DIR..."
  git clone "$REPO_URL" "$DEST_DIR"
else
  echo "Репозиторий уже существует в $DEST_DIR. Обновляем "
  cd "$DEST_DIR" || exit
  git pull origin main  
fi

# на всякий случай
chmod -R 755 "$DEST_DIR"

cd "$DEST_DIR" 



docker-compose up -d


