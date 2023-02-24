#!/bin/bash

# With all the required programs reinstalled:

ipBkpServ=0.0.0.0	  		            # IP of your backup server
portBkpServer=22                  # SSH port of backup server (default: 22)
usrBkpServ=username			            # Username of backup server
folderBkpServ=/folder/ofBackup		# Folder of your backup server
restoreFolder=/var/lib/libvirt/images   # Restore directly to the original place

rsync -ave 'ssh -p $portBkpServer' $usrBkpServ@$ipBkpServ:$folderBkpServ $restoreFolder/restore

for vm in $restoreFolder/restore/*
do
 	vm=${vm##*/}
    virsh define $vm/$vm.xml
    mv $vm/$vm.qcow2 $restoreFolder
done
rm -r $restoreFolder/restore
