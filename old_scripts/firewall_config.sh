

sudo apt-get install -y ufw
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 2003/tcp
sudo ufw allow 4505:4506/tcp
sudo ufw enable

ssh -t ubuntu@mon1  " 	sudo apt update 
			sudo apt-get install -y ufw && \
			sudo ufw allow 22/tcp && \
			sudo ufw allow 6789/tcp && \
			sudo ufw enable"


ssh -t ubuntu@ceph-osd1 " 	sudo apt update 
				sudo apt-get install -y ufw && \
				sudo ufw allow 22/tcp && \
				sudo ufw allow 6800:7300/tcp && \
				sudo ufw enable"

ssh -t ubuntu@ceph-osd2 " 	sudo apt update 
				sudo apt-get install -y ufw && \
				sudo ufw allow 22/tcp && \
				sudo ufw allow 6800:7300/tcp && \
				sudo ufw enable"

ssh -t ubuntu@ceph-osd3 " 	sudo apt update 
				sudo apt-get install -y ufw && \
				sudo ufw allow 22/tcp && \
				sudo ufw allow 6800:7300/tcp && \
				sudo ufw enable"




