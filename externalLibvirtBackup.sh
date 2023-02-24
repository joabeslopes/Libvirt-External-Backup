#!/bin/bash

# Make shure that the vm domain and the vm disk name are the same, otherwise it didn't work

# This method also works with the vm running, but i don't know if it can really broken the file. Until now it didn´t happened to me.


ipBkpServ=0.0.0.0	  		# IP of your backup server
portBkpServer=22                        # SSH port of backup server (default: 22)
usrBkpServ=username			# Username of backup server
folderBkpServ=/folder/of/VMbackup		# Folder of your backup server

cd /var/lib/libvirt/images
for vm in ./*
do
	vm=${vm%*.qcow2}
 	vm=${vm##*/}
# this 2 lines are there for apply a 'filter', keeping only the vm name on the variable
	virsh dumpxml $vm > $vm.xml
	rsync -ave 'ssh -p $portBkpServer' --mkpath $vm.* $usrBkpServ@$ipBkpServ:$folderBkpServ/$vm/
rm $vm.xml
done
