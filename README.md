# docker-borg-restore - A docker container to restore a borg backup

To use, mount the volumes you wish to restore under /restore, then configure the following secrets/environment variables:

|Secret|Description|
|---|---|
|`borg_ssh_key`|The private key used for remote backups|
|`borg_passphrase`|The passphrase to use with `repokey` encrypted repositories (Required when `BORG_ENCRYPTION` is `repokey`)|

|Variable|Default|Description|
|---|---|---|
|`BORG_REPO`|_none_|The source borg repository where archives are stored (Required)|
|`BORG_ARCHIVE_NAME`|_none_|The archive name to restore, defaults to the latest archive in the repo|
|`BORG_REMOTE_PATH`|_none_|If set, the path to the borg executable on the server|
|`BORG_STRIP_COMPONENTS`|`1`|The number of path components to strip when restoring the archive|
