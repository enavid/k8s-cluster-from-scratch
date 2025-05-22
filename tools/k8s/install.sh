sudo rpm -ivh ./libnetfilter_queue-1.0.5-1.el9.x86_64.rpm
sudo rpm -ivh ./libnetfilter_cttimeout-1.0.0-19.el9.x86_64.rpm
sudo rpm -ivh ./libnetfilter_cthelper-1.0.0-22.el9.x86_64.rpm 
sudo rpm -ivh ./kubernetes-cni-1.6.0-150500.1.1.x86_64.rpm 
sudo rpm -ivh ./cri-tools-1.32.0-150500.1.1.x86_64.rpm 
sudo rpm -ivh ./conntrack-tools-1.4.7-4.el9_5.x86_64.rpm 
sudo rpm -ivh ./kubelet-1.32.2-150500.1.1.x86_64.rpm                                                                                                     
sudo rpm -ivh ./kubeadm-1.32.2-150500.1.1.x86_64.rpm                                                                   
sudo rpm -ivh ./kubectl-1.32.2-150500.1.1.x86_64.rpm  

sudo systemctl enable kubelet.service
                                                                                                                                                                                           
