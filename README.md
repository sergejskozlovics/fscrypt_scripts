# fscrypt_scripts

Scripts for initializing and mounting/unmounting encrypted folders in Linux. The scripts are useful for remote servers that require encrypted file storage but where it is unfeasible to deploy full-disk encryption (due to possible reboots).

Just launch `./fscrypt_install.sh` and answer the questions (sudo required). It will create two scripts, `mount_<your_dir_alias>.sh` and `umount_<your_dir_alias>.sh`.

The `./after_reboot.sh` script can be used to mount all encrypted directories after the server reboot.

See also: [How To Encrypt and Securely Backup Directories in Ubuntu](https://sergejskozlovics.medium.com/how-to-encrypt-and-securely-backup-directories-in-ubuntu-727ea9362049) (my medium.com article)





