#!/bin/bash

# Make shure that the vm domain and the vm disk name are the same, otherwise it didn't work

# This method also works with the vm running, but i don't know if it can really broken the file. Until now it didn´t happened to me.


IpBkpServ=0.0.0.0	  		# IP of your backup server
UsrBkpServ=username			# Username of backup server
FolderBkpServ=/folder/of/backup		# Folder of your backup server

cd /var/lib/libvirt/images
for vm in ./*
do
	vm=${vm%*.qcow2}
 	vm=${vm##*/}
# this 2 lines are there for apply a 'filter', keeping only the vm name on the variable
	virsh dumpxml $vm > $vm.xml
	rsync -av --mkpath $vm.xml $UsrBkpServ@$IpBkpServ:$FolderBkpServ/$vm/
	rsync -av --mkpath $vm.qcow2 $UsrBkpServ@$IpBkpServ:$FolderBkpServ/$vm/
rm $vm.xml
done
