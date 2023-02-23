#!/bin/bash

# With all the required programs reinstalled:

IpBkpServ=0.0.0.0	  		            # IP of your backup server
UsrBkpServ=username			            # Username of backup server
FolderBkpServ=/folder/of/VMbackup		# Folder of your backup server
restoreFolder=/var/lib/libvirt/images   # Restore directly to the original place

rsync -av $UsrBkpServ@$IpBkpServ:$FolderBkpServ $restoreFolder/restore

for vm in $restoreFolder/restore/*
do
 	vm=${vm##*/}
    virsh define $vm/$vm.xml
    mv $vm/$vm.qcow2 $restoreFolder
done
rm -r $restoreFolder/restore
