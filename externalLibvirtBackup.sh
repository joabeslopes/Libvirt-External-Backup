#!/bin/bash

# Make shure that the vm domain and the vm disk name are the same, otherwise it didn't work

# This method also works with the vm running, but i don't know if it can really broken the file. Until now it didn´t happened to me.


ipBkpSrv=0.0.0.0	  		# IP of your backup server
portBkpSrv=22                        # SSH port of backup server (default)
userBkpSrv=user			# Username of backup server
folderBkpSrv=/VM/backup/folder		# Folder of your backup server
VmFolder=/var/lib/libvirt/images		# Libvirt folder for the VM disks (default)

cd $VmFolder
for vm in ./*
do
	vm=${vm%*.qcow2}
 	vm=${vm##*/}
# this 2 lines are there for apply a 'filter', keeping only the vm name on the variable

	virsh dumpxml $vm > $vm.xml
	rsync -ave "ssh -p $portBkpSrv" --mkpath $vm.* $userBkpSrv@$ipBkpSrv:$folderBkpSrv/$vm/
rm $vm.xml
done
