

ssh -t ubuntu@ceph-mon1 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"
ssh -t ubuntu@ceph-osd1 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"
ssh -t ubuntu@ceph-osd2 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"
ssh -t ubuntu@ceph-osd3 "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"
ssh -t ubuntu@ceph-client "sudo mkdir /home/cephuser/.ssh/ && sudo cat id_rsa.pub | sudo tee /home/cephuser/.ssh/authorized_keys >/dev/null"

