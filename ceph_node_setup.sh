


sudo apt update
sudo apt-get install -y ntp ntpdate ntp-doc
sudo ntpdate 0.us.pool.ntp.org
sudo hwclock --systohc
sudo systemctl enable ntp
sudo systemctl start ntp

sudo apt install -y openssh-server

sudo useradd -m -s /bin/bash cephuser
echo -e  "Sdafds24324dss\nSdafds24324dss\n" | sudo passwd cephuser -q
echo "cephuser ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cephuser
chmod 0440 /etc/sudoers.d/cephuser
sed -i s'/Defaults requiretty/#Defaults requiretty'/g /etc/sudoers


sudo apt-get install -y open-vm-tools
sudo apt-get install -y python python-pip parted


sudo sed -i '3i10.100.6.211   admin' /etc/hosts
sudo sed -i '3i10.100.28.134  node1' /etc/hosts
sudo sed -i '3i10.100.21.162  node2' /etc/hosts
sudo sed -i '3i10.100.20.175  node3' /etc/hosts

# firewall config 
sudo apt update			
sudo apt-get install -y ufw
sudo ufw allow 22/tcp 
sudo ufw allow 6789/tcp
sudo ufw allow 6800:7300/tcp
yes | sudo ufw enable



