


ssh -t ubuntu@ceph-osd1 "	sudo parted -s /dev/xvdb mklabel gpt mkpart primary xfs 0% 100%	
				sudo mkfs.xfs -f /dev/xvdb" 

ssh -t ubuntu@ceph-osd2 "	sudo parted -s /dev/xvdb mklabel gpt mkpart primary xfs 0% 100%	
				sudo mkfs.xfs -f /dev/xvdb" 

ssh -t ubuntu@ceph-osd3 "	sudo parted -s /dev/xvdb mklabel gpt mkpart primary xfs 0% 100%	
				sudo mkfs.xfs -f /dev/xvdb" 


