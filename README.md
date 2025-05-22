# Offline Kubernetes Cluster Setup with Containerd, Calico, Longhorn, and MetalLB

This project demonstrates the **offline setup of a multi-node Kubernetes cluster** using AlmaLinux servers. The goal was to simulate a real-world, production-like environment **without internet access** as part of a personal DevOps training exercise.

> ⚠️ Note: All required packages and container images were **manually downloaded in advance**.
> If you're following this guide for a production deployment, it's strongly recommended to download the **latest versions** of each component directly from their official sources.

---

## 🧠 Project Goal

- Learn how Kubernetes works under the hood.
- Practice setting up a fully functional cluster in air-gapped environments.
- Get hands-on experience with real tools like Longhorn, Calico, and MetalLB.

---

## 📊 System Architecture

Below is a simplified diagram of the technologies used:

```
+------------------+
|  MetalLB         |  <-- LoadBalancer for external traffic
+------------------+
        |
        v
+--------------------------+
| Ingress NGINX Controller|
+--------------------------+
        |
        v
+-------------------------+
| Kubernetes Cluster     |
| - kubeadm, kubectl     |
| - Calico (CNI)         | <-- Network policy and overlay network
| - Longhorn (Storage)   | <-- Distributed persistent volumes
+-------------------------+
        |
        v
+---------------------------+
| Container Runtime:        |
| - containerd              |
+---------------------------+
```

---

## 🔧 Technologies Used

| Tool                    | Purpose                                                           |
| ----------------------- | ----------------------------------------------------------------- |
| **kubeadm**       | Initializes the Kubernetes control-plane and joins worker nodes   |
| **containerd**    | Lightweight and production-ready container runtime                |
| **Calico**        | Implements Kubernetes CNI, provides networking and network policy |
| **Longhorn**      | Distributed block storage for Kubernetes, useful for RWX volumes  |
| **MetalLB**       | LoadBalancer implementation for bare-metal clusters               |
| **Ingress NGINX** | Handles HTTP routing to services inside the cluster               |

---

## 🖥️ Nodes Used

This cluster was built using:

- **6 AlmaLinux servers**
  - **1 master**
  - **5 worker nodes**

You can scale the number of worker nodes **up or down** as needed.

---

## 📁 Repo Contents

This repository includes:

- Shell scripts for offline package installation
- YAML manifests for Kubernetes components
- Preloaded container images
- Configuration files for kubeadm and network/storage tools

---

## 📎 Download This Project

You can clone or download the repository from GitHub using the following link:

```bash
git clone https://github.com/enavid/k8s-cluster-from-scratch.git
```

---

## 📦 Deployment Instructions

For detailed setup steps, please see the [INSTALLATION.md](./docs/INSTALLATION.md) guide included in this repository.

