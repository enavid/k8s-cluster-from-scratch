#1 Increate vm max map counte
sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count=262144" >> /etc/sysctl.conf
sudo sysctl -p

#2 Install iscsi initator
sudo chmod +x ./tools/iscsi-initiator-utils/install.sh
sudo ./tools/iscsi-initiator-utils/install.sh

#3 Install nfs utils
sudo chmod +x ./tools/nfs-utils/install.sh 
sudo ./tools/nfs-utils/install.sh

#4 Install containerd
sudo chmod +x ./tools/containerd/install.sh 
sudo ./tools/containerd/install.sh 

#5 Load Pre-downloaded Images
sudo ctr -n k8s.io image import ./images/ingress.tar
sudo ctr -n k8s.io image import ./images/k8s-images.tar
sudo ctr -n k8s.io image import ./images/longhornio.tar

#6 Install kubernetes
sudo chmod +x ./tools/k8s/install.sh
sudo ./tools/k8s/install.sh