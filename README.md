# Go WebApp CI/CD with Kubernetes and ArgoCD

This project demonstrates a complete **CI/CD and GitOps pipeline** for a Golang web application using **Docker, Kubernetes (k3d), Helm, GitHub Actions and ArgoCD**.

The application is automatically built, containerized and deployed to Kubernetes whenever code changes are pushed to GitHub.

---

## Project Flow

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
k3d cluster create go-web-app
--servers 1
--agents 1
-p "80:80@loadbalancer"
-p "443:443@loadbalancer"
--k3s-arg "--disable=traefik@server:0"

---

## Install NGINX Ingress Controller
helm upgrade --install ingress-nginx ingress-nginx
--repo https://kubernetes.github.io/ingress-nginx

--namespace ingress-nginx
--create-namespace

---

## Install ArgoCD

Create namespace:
kubectl create namespace argocd

Install ArgoCD:
kubectl apply -n argocd --server-side --force-conflicts
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

---

## Access ArgoCD UI
kubectl port-forward svc/argocd-server -n argocd 8080:443 (or) use nodePort 

---

## Deploy Application using Helm
helm install go-web-app ./helm/go-web-app

---

## Application Endpoint

https://<ngrok-domain>/courses (for ngrok domain: ngrok http 80)
NOTE: The Same Domain Name should be there in ingress.yaml

---

## Author

Keerthan



