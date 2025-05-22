cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system
sysctl net.ipv4.ip_forward

sudo swapoff -a

sudo rpm -ivh ./container-selinux-2.232.1-1.el9.noarch.rpm
sudo rpm -ivh ./containerd.io-1.7.25-3.1.el9.x86_64.rpm
sudo systemctl enable --now  containerd
sudo cp ./config.toml /etc/containerd/config.toml


