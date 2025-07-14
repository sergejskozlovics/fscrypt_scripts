#!/bin/sh

MAIN_DIR=`dirname $0`

for script in "$MAIN_DIR"/mount_*.sh; do
  [ -e "$script" ] || continue  # Skip if no match
  echo "Launching $script..."
  bash "$script"
done


