
# install packages
wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -
echo deb https://download.ceph.com/debian/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt update
sudo apt install -y ceph-deploy
sudo apt install -y ntp

# ceph deploy firewall
sudo apt-get install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 2003/tcp
sudo ufw allow 4505:4506/tcp
sudo ufw enable

# setup admin node
sudo ./ceph_node_setup.sh

ssh-keyscan node1 node2 node3 >> ~/.ssh/known_hosts



#setup nodes
scp ./ceph_node_setup.sh ubuntu@node1:~/
ssh -t ubuntu@node1 "sudo hostname \"node1\" && sudo sh -c \"hostname | sudo tee /etc/hostname > /dev/null\""
ssh -t ubuntu@node1 "sudo chmod +x ./ceph_node_setup.sh && sudo ./ceph_node_setup.sh"
scp ./ssh/id_rsa.pub ubuntu@node1:~/
ssh -t ubuntu@node1 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"




scp ./ceph_node_setup.sh ubuntu@node2:~/
ssh -t ubuntu@node2 "sudo hostname \"node2\" && sudo sh -c \"hostname | sudo tee /etc/hostname > /dev/null\""
ssh -t ubuntu@node2 "sudo chmod +x ./ceph_node_setup.sh && sudo ./ceph_node_setup.sh"
scp ./ssh/id_rsa.pub ubuntu@node2:~/
ssh -t ubuntu@node2 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"


scp ./ceph_node_setup.sh ubuntu@node3:~/
ssh -t ubuntu@node3 "sudo hostname \"node3\" && sudo sh -c \"hostname | sudo tee /etc/hostname > /dev/null\""
ssh -t ubuntu@node3 "sudo chmod +x ./ceph_node_setup.sh && sudo ./ceph_node_setup.sh"
scp ./ssh/id_rsa.pub ubuntu@node3:~/
ssh -t ubuntu@node3 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"



sudo cp -r ssh /home/cephuser/.ssh/
sudo chmod -R 600 /home/cephuser/.ssh/
sudo chmod +x /home/cephuser/.ssh/
sudo chown -R cephuser:cephuser /home/cephuser/.ssh/
sudo su cephuser
sudo chmod 644 ~/.ssh/config
ssh-keyscan admin node1 node2 node3 >> ~/.ssh/known_hosts


sudo hostname "admin"
sudo sh -c "hostname | sudo tee /etc/hostname"


ssh -t cephuser@node1 "	sudo parted -s /dev/xvdb mklabel gpt mkpart primary xfs 0% 100%	
			sudo mkfs.xfs -f /dev/xvdb
			sudo partprobe /dev/xvdb" 
ssh -t cephuser@node2 "	sudo parted -s /dev/xvdb mklabel gpt mkpart primary xfs 0% 100%	
			sudo mkfs.xfs -f /dev/xvdb
			sudo partprobe /dev/xvdb" 
ssh -t cephuser@node3 "	sudo parted -s /dev/xvdb mklabel gpt mkpart primary xfs 0% 100%	
			sudo mkfs.xfs -f /dev/xvdb 
			sudo partprobe /dev/xvdb" 

mkdir ~/my-cluster
cd ~/my-cluster
ceph-deploy new node1 
printf "public network = 10.100.16.0/16\n" >> ceph.conf
printf "osd_max_object_name_len = 256\n" >> ceph.conf
printf "osd_max_object_namespace_len = 64\n" >> ceph.conf
printf "osd pool default size = 2\n" >> ceph.conf
printf "echo ms bind ipv6 = true" >> ceph.conf


ceph-deploy install --stable=luminous node1 node2 node3
ceph-deploy mon create-initial
ceph-deploy disk zap node1:/dev/xvdb node2:/dev/xvdb node3:/dev/xvdb

ssh -t cephuser@admin "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node1 "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node2 "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node3 "sudo chmod -R 644 /etc/ceph/"

ceph-deploy osd create node1:/dev/xvdb node2:/dev/xvdb node3:/dev/xvdb
ssh -t cephuser@admin "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node1 "sudo chmod -R 644 /etc/ceph/ceph.client.admin.keyring"
ssh -t cephuser@node2 "sudo chmod -R 644 /etc/ceph/ceph.client.admin.keyring"
ssh -t cephuser@node3 "sudo chmod -R 644 /etc/ceph/ceph.client.admin.keyring"


ceph-deploy admin node1 node2 node3
ssh -t cephuser@admin "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node1 "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node2 "sudo chmod -R 644 /etc/ceph/"
ssh -t cephuser@node3 "sudo chmod -R 644 /etc/ceph/"






