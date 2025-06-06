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

# ( export all container images )
ctr -n k8s.io images export all-images.tar $(crictl images -q)

# ( get pods in ingress namespace )
kubectl get pods -n ingress-nginx -o wide

# ( get ingress controller service info )
kubectl get svc ingress-nginx-controller -n ingress-nginx

# ( view ingress controller logs - direct )
kubectl logs -f deployment/ingress-nginx-controller -n ingress-nginx

# ( view ingress controller logs - by label )
kubectl logs -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx --tail=100 -f
```

---

### 🖥️ Hosts File Configuration

#### On Linux:

Edit `/etc/hosts` using any text editor (e.g. nano):

```bash
sudo nano /etc/hosts
```

#### On Windows:

Edit the file using Notepad (Run as Administrator):

```
C:\Windows\System32\drivers\etc\hosts
```

---

📘 For detailed installation steps, refer to [INSTALLATION.md](./installation/INSTALLATION.md).
