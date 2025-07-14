#!/bin/bash

#sudo apt install fscrypt
fscrypt status

read -p "For which device do you want to enable fscrypt (the device must be mounted!):" FSCRYPT_DEVICE
sudo tune2fs -O encrypt $FSCRYPT_DEVICE

# Get the canonical device path (resolves symlinks like /dev/root)
FSCRYPT_DEVICE=$(readlink -f "$FSCRYPT_DEVICE")

# Use findmnt to get the mount point
MOUNT_POINT=$(findmnt -n -o TARGET --source "$FSCRYPT_DEVICE" | head -n1)

if [ -n "$MOUNT_POINT" ]; then
  echo "✅ Device $FSCRYPT_DEVICE is mounted at: $MOUNT_POINT"
else
  echo "❌ Device $FSCRYPT_DEVICE is not mounted."
  exit
fi

sudo tune2fs -O encrypt $FSCRYPT_DEVICE

if [ ! -f /etc/fscrypt.conf ]; then
  sudo fscrypt setup
fi
sudo fscrypt setup $MOUNT_POINT
fscrypt status

##### Creating the dir inside mount Point
MOUNT_POINT=$(realpath -e "$MOUNT_POINT")

echo "Current directory is $PWD."
read -p "Enter the encrypted directory path (must be within $MOUNT_POINT): " FSCRYPT_DIR

# Resolve input to absolute path
FSCRYPT_DIR=$(realpath -m "$FSCRYPT_DIR")
echo "You've entered: $FSCRYPT_DIR."

# Check if the resolved path starts with MOUNT_POINT
if [[ "$FSCRYPT_DIR" == "$MOUNT_POINT/"* || "$MOUNT_POINT" == "/" ]]; then
  echo "✅ Path is inside MOUNT_POINT."
else
  echo "❌ Path is NOT inside MOUNT_POINT."
  exit
fi

mkdir -p $FSCRYPT_DIR

fscrypt encrypt "$FSCRYPT_DIR"

if fscrypt status "$FSCRYPT_DIR" 2>/dev/null | grep -q "Unlocked: Yes"; then
  echo "✅ Directory is encrypted and unlocked."
elif fscrypt status "$FSCRYPT_DIR" 2>/dev/null | grep -q "Encrypted: Yes"; then
  echo "🔒 Directory is encrypted but locked."
else
  echo "📂 Directory is not encrypted (or fscrypt not initialized)."
  exit
fi

read -p "Enter the alias for this folder (we will create the mount and umount scripts): " ALIAS
echo "fscrypt unlock $FSCRYPT_DIR" > mount_$ALIAS.sh
echo "fscrypt lock $FSCRYPT_DIR" > umount_$ALIAS.sh
chmod +x mount_$ALIAS.sh
chmod +x umount_$ALIAS.sh
