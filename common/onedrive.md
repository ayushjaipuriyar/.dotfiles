# Setup rclone for onedrive

``` bash

paru rclone
rclone config

mkdir ~/onedrive

rclone --vfs-cache-mode writes mount "onerive": ~/onedrive

```
