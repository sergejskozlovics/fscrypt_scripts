# fscrypt_scripts

Scripts for initializing and mounting/unmount encrypted folders in Linux (useful for servers without full-disk encryption)
Just launch ./fscrypt_install.sh and answer the questions (sudo required).
It will create two scripts mount_<your_dir_alias>.sh and umount_<your_dir_alias>.sh.

The ./after_reboot.sh script can be used to mount all encrypted directories after the server reboot.

See also: [How To Encrypt and Securely Backup Directories in Ubuntu](https://sergejskozlovics.medium.com/how-to-encrypt-and-securely-backup-directories-in-ubuntu-727ea9362049) (my medium.com article)



