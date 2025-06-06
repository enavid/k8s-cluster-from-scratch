# 🛠️ Kubernetes Offline Cluster Installation Guide

This document provides a **step-by-step installation guide** for setting up a multi-node Kubernetes cluster **completely offline** using AlmaLinux servers.

> 📌 This setup was created for **learning and practice purposes**, so all dependencies, images, and packages were **downloaded in advance** and installed manually.

---

## 📋 Prerequisites

- 6 AlmaLinux 9.x servers (1 Master + 5 Workers)
- User with sudo privileges on all nodes
- All `.rpm` packages and `.tar` container images downloaded locally
- Cloned or downloaded version of this GitHub repository

---

## ⚙️ 1. Set Hostnames ( **All Nodes** )

On each node, set a unique hostname:

```bash
sudo hostnamectl set-hostname master-1     # On master node
sudo hostnamectl set-hostname worker-1     # Example for workers
```

Then update `/etc/hosts`:

```bash
sudo nano /etc/hosts
# Add all node IPs with their hostnames
```

---

## 🧹 2. Disable Swap ( **All Nodes** )

```bash
sudo swapoff -a
sudo nano /etc/fstab   # Comment out any swap entries
free -h                # Confirm swap is off
```

---

## 📦 3. Install Prerequisites & Load Images ( **All Nodes** )

To automate setup of required packages and image loading, use the provided script:

```bash
sudo chmod +x ./tools/install.sh
sudo ./tools/install.sh
```

---

### 📌 Transition Note

> **Up to this point, all steps must be performed on *all* nodes — both master and workers.**
>
> Now, in **Step 4**, you will initialize the Kubernetes cluster **only on the master node** using `kubeadm init`.
>
> After that, the `kubeadm init` command will print a `kubeadm join ...` command.
> **You must run that join command on each worker node** to connect them to the cluster.
>
> Once all workers have joined the cluster, you can verify node registration on the master by running:
>
> ```bash
> kubectl get nodes -A
> ```
>
> From **Step 5 onward, all remaining actions will be performed *only on the master node.***

---

---

## 🚀 4. Initialize Master Node (Master Node Only)

```bash
cd kubeadm-config/
sudo kubeadm init --config=./kubeadm-config/kubeadm-config.yml # You can include your desired settings in the kubeadm-config.yml file.
```

Then set up the kubeconfig for your non-root user:

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

---

## 🌐 5. Install Network Plugin Calico (Master Node Only)

```bash
kubectl create -f ./manifests/calico/tigera-operator.yml
kubectl create -f ./manifests/calico/custom-resources.yml
```

---

## 💾 6. Install Longhorn Storage (Master Node Only)

```bash
kubectl create -f ./manifests/longhorn/longhorn.yml
```

You can verify volumes and storage classes via:

```bash
kubectl get sc
kubectl get pods -n longhorn-system
```

---

## 🌐 7. Configure Ingress and Load Balancer MetalLB (Master Node Only)

```bash
kubectl apply -f ./manifests/metallb/ingress-nginx-controller.yml
kubectl apply -f ./manifests/metallb/ingress-nginx-patch.yml
kubectl apply -f ./manifests/metallb/metallb-native.yml
kubectl apply -f ./manifests/metallb/metallb-config.yml
kubectl apply -f ./manifests/ingress/longhorn-ingress.yml
```

---

## 🔍 8. Run Environment Checks (Optional)

To verify if Longhorn and other components can function correctly:

```bash
cd scripts/
chmod +x environment_check.sh
./environment_check.sh
```

---

## ✅ Final Words

- You can scale this cluster by adding or removing worker nodes as needed.
- This setup is ideal for test labs, air-gapped environments, or practicing DevOps skills.
- For production, ensure security hardening, backups, and up-to-date versions.
- For additional helper commands, see [HELPFUL-COMMANDS.md](./HELPFUL-COMMANDS.md).

---

> Built for learning. Designed for practice. Inspired by real-world challenges.
