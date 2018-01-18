
sudo su
su - cephuser 
cp -rf ssh /home/cephuser/.ssh
chown -R cephuser:cephuser /home/cephuser/.ssh 
chmod -R 600 /home/cephuser/.ssh
chmod 644 /home/cephuser/.ssh/config

 
