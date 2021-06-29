# create a bootable usb from ISO


### find the usb you have plugged in
```
df -h
```

### unmount the disk
```
sudo umount <usb> eg. /dev/sdb1
```

### write the disk
```
sudo dd if=<path/to/file.iso> of=<path/to/usb> bs=1M status=progress
```

### example
```
-- sudo dd if=artful-desktop-amd64.iso of=/dev/sdb1 bs=1M status=progress
```
