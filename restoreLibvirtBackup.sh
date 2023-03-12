#!/bin/bash

# Before do it, don't forget to reinstall all the necessary packages of virt-manager, rsync, ...

ipBkpSrv=0.0.0.0	  		# IP of your backup server
portBkpSrv=22                        # SSH port of backup server (default)
userBkpSrv=user			# Username of backup server
folderBkpSrv=/VM/backup/folder		# Folder of your backup server
vmFolder=/var/lib/libvirt/images		# Libvirt folder for the VM disks (default)

rsync -ave "ssh -p $portBkpSrv" --mkpath $userBkpSrv@$ipBkpSrv:$folderBkpSrv/* $vmFolder/restore

for vm in $vmFolder/restore/*
do
        vm=${vm##*/}
        mv $vmFolder/restore/$vm/$vm.qcow2 $vmFolder
        virsh define $vmFolder/restore/$vm/$vm.xml
done
rm -r $vmFolder/restore
