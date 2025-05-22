## 🧪 Useful Commands

```bash
# ( check IP )
ip a

# ( check cert )
sudo kubeadm certs check-expiration

# ( node detail )
sudo kubectl get node --kubeconfig /etc/kubernetes/admin.conf

# ( ignore error )
--ignore-preflight-errors=NumCPU

# ( for reset cluster )
sudo kubeadm reset -f

# ( for taint master )
kubectl taint nodes --all node-role.kubernetes.io/control-plane-

# ( restart ingress controller )
kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx
```

---

📘 For detailed installation steps, refer to [INSTALLATION.md](./installation/INSTALLATION.md).
