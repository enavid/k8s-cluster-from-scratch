
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

## ⚙️ 1. Set Hostnames

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

## 🧹 2. Disable Swap

```bash
sudo swapoff -a
sudo nano /etc/fstab   # Comment out any swap entries
free -h           # Confirm swap is off
```

---

## 📦 3. Install Required Packages

Use the offline `.rpm` packages provided under `tools/`.

Example for containerd:

```bash
cd tools/containerd
chmod +x install.sh
./install.sh
```

Repeat for:
- `k8s/`
- `iscsi-initiator-utils/`
- `nfs-utils/`

---

## 🐳 4. Load Pre-downloaded Images

```bash
ctr -n k8s.io image import ./images/k8s-images.tar
ctr -n k8s.io image import ./images/ingress.tar
ctr -n k8s.io image import ./images/longhornio.tar
```

---

## 🚀 5. Initialize Master Node

```bash
cd kubeadm-config/
kubeadm init --config=kubeadm-config.yml
```

Then set up the kubeconfig for your non-root user:

```bash
mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
```

To allow master to schedule pods:

```bash
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```

---

## 🌐 6. Install Network Plugin (Calico)

```bash
kubectl apply -f manifests/calico/tigera-operator.yml
kubectl apply -f manifests/calico/custom-resources.yml
```

---

## 💾 7. Install Longhorn Storage

```bash
kubectl apply -f manifests/longhorn/longhorn.yml
```

You can verify volumes and storage classes via:

```bash
kubectl get sc
kubectl get pods -n longhorn-system
```

---

## 🌐 8. Configure Ingress and Load Balancer (MetalLB)

```bash
kubectl apply -f manifests/metallb/metallb-native.yml
kubectl apply -f manifests/metallb/ingress-nginx-controller.yml
kubectl apply -f manifests/metallb/ingress-nginx-patch.yml
kubectl apply -f manifests/metallb/metallb-config.yml
```

Restart the ingress controller:

```bash
kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx
```

---

## 🔍 9. Run Environment Checks (Optional)

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

---

> Built for learning. Designed for practice. Inspired by real-world challenges.
