#!/bin/bash

# With all the required programs reinstalled:

ipBkpServ=0.0.0.0	  	        # IP of your backup server
portBkpServer=22                        # SSH port of backup server (default: 22)
usrBkpServ=username		        # Username of backup server
FolderBkpServ=/backup/vms		# Folder of your backup server
restoreFolder=/var/lib/libvirt/images   # Restore directly to the original place

rsync -av $UsrBkpServ@$IpBkpServ:$FolderBkpServ/* $restoreFolder/restore

for vm in $restoreFolder/restore/*
do
        vm=${vm##*/}
        mv $restoreFolder/restore/$vm/$vm.qcow2 $restoreFolder
        virsh define $restoreFolder/restore/$vm/$vm.xml
done
rm -r $restoreFolder/restore
