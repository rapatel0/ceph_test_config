
sudo useradd -m -s /bin/bash cephuser
sudo passwd cephuser
echo "cephuser ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/cephuser
chmod 0440 /etc/sudoers.d/cephuser
sed -i s'/Defaults requiretty/#Defaults requiretty'/g /etc/sudoers


sudo apt update
sudo apt-get install -y ntp ntpdate ntp-doc
sudo ntpdate 0.us.pool.ntp.org
sudo hwclock --systohc
sudo systemctl enable ntp
sudo systemctl start ntp

sudo apt-get install -y open-vm-tools
sudo apt-get install -y python python-pip parted

sudo sed -i '3i10.100.21.21    ceph-admin' /etc/hosts
sudo sed -i '3i10.100.24.43    mon1     ' /etc/hosts
sudo sed -i '3i10.100.28.212   ceph-osd1' /etc/hosts
sudo sed -i '3i10.100.17.26    ceph-osd2' /etc/hosts
sudo sed -i '3i10.100.17.224   ceph-osd3' /etc/hosts
sudo sed -i '3i10.100.16.50    ceph-client' /etc/hosts

