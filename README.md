# Go WebApp CI/CD with Kubernetes and ArgoCD

This project demonstrates a complete **CI/CD and GitOps pipeline** for a Golang web application using **Docker, Kubernetes (k3d), Helm, GitHub Actions and ArgoCD**.

The application is automatically built, containerized and deployed to Kubernetes whenever code changes are pushed to GitHub.

---

## Project Flow

```
Developer Push
    ↓
GitHub Repository
    ↓
GitHub Actions CI Pipeline
(Build → Test → Lint)
    ↓
Docker Image Build
    ↓
DockerHub Push
    ↓
Helm values.yaml Updated
    ↓
Git Commit
    ↓
ArgoCD Detects Change
    ↓
Auto Sync Deployment
    ↓
k3d Kubernetes Cluster
    ↓
NGINX Ingress Controller
    ↓
Ngrok Tunnel
    ↓
Internet Access
```

---

## Tools Used

- Golang
- Docker (Multi-stage + Distroless)
- Kubernetes (k3d)
- Helm
- GitHub Actions
- DockerHub
- ArgoCD
- NGINX Ingress Controller
- Ngrok

---

## Create k3d Cluster

```bash
k3d cluster create go-web-app \
--servers 1 \
--agents 1 \
-p "80:80@loadbalancer" \
-p "443:443@loadbalancer" \
--k3s-arg "--disable=traefik@server:0"
```

Verify cluster:

```bash
kubectl get nodes
```

---

## Install NGINX Ingress Controller

```bash
helm upgrade --install ingress-nginx ingress-nginx \
--repo https://kubernetes.github.io/ingress-nginx \
--namespace ingress-nginx \
--create-namespace
```

Verify installation:

```bash
kubectl get pods -n ingress-nginx
```

---

## Install ArgoCD

Create namespace:

```bash
kubectl create namespace argocd
```

Install ArgoCD:

```bash
kubectl apply -n argocd \
--server-side \
--force-conflicts \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify installation:

```bash
kubectl get pods -n argocd
```

---

## Access ArgoCD UI

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:80
```

Or use NodePort.

Open in browser:

```
https://localhost:8080
```

---

## Deploy Application using Helm

```bash
helm install go-web-app ./helm/go-web-app
```

Verify resources:

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
```

---

## Application Endpoint

Start ngrok:

```bash
ngrok http 80
```

Example endpoint:

```
https://<ngrok-domain>/courses
```

Note:

The same domain name must be configured in `ingress.yaml`.

---

## Author

Keerthan
