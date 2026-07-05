# Architecture (fill this in)

## 1. Topology diagram
> Draw it (ASCII, Excalidraw, draw.io — anything). Show: your nodes, where each TaskApp
> tier runs, the ingress controller, and the request path.

                        Internet
                            │
                            │
                    helloisthisjojo.shop
                            │
                     Route53 / DNS
                            │
                     AWS Security Group
                            │
                  Traefik Ingress Controller
                            │
          ┌─────────────────┴─────────────────┐
          │                                   │
          ▼                                   ▼
Frontend Service                        Backend Service
          │                                   │
    2 Frontend Pods                     2 Backend Pods
          │                                   │
          └───────────────API─────────────────┘
                          │
                          ▼
                  PostgreSQL Service
                          │
                    PostgreSQL StatefulSet
                          │
                     Persistent Volume

## 2. Node & network
Node	                    Role	                Region
Control Plane     Kubernetes API Server	        eu-north-1
Worker 1	      Application workloads	        eu-north-1
Worker 2	      Application workloads	        eu-north-1

Firewall

Open:

22 SSH
80 HTTP
443 HTTPS

Internal only:

6443 Kubernetes API
Pod networking

The Kubernetes API is not exposed publicly for security.

## 3. Request flow (one paragraph)
A client requests https://helloisthisjojo.shop. DNS resolves the domain to the control plane public IP where Traefik receives the request. Traefik terminates TLS using certificates issued by cert-manager and Let's Encrypt. Requests for / are routed to the Frontend Service on port 80, while requests for /api are routed to the Backend Service on port 5000. The backend communicates with PostgreSQL through the internal PostgreSQL Service on port 5432 using Kubernetes DNS.

## 4. The single-server assumptions you fixed  ← graders look here
Single-server assumption	       Why it breaks	                         Solution
Database on localhost               Doesn't exist across nodes      PostgreSQL Service + StatefulSet
Local Docker volume	            Lost if pod moves	                  Persistent Volume Claim
One backend container	            Single point of failure	            Multiple backend replicas
One frontend container	            Downtime during updates	            Rolling Deployments
Manual deployment	                  Error prone	                        GitHub Actions + ArgoCD
Environment variables in code	      Not secure	                        Kubernetes Secrets
Direct container access	            Doesn't scale	                  ClusterIP Services
HTTP only	                        Insecure	              Traefik + cert-manager + Let's Encrypt

## 5. Choices & trade-offs
Raw YAML

Raw Kubernetes YAML was selected because it provides complete visibility into every resource and aligns with the capstone requirements.

Traefik

K3s includes Traefik by default, reducing setup complexity while still supporting TLS and Ingress resources.

Networking

Flannel (the default K3s CNI) was used. Network Policies were not enforced because they were outside the project scope.

Secrets

Native Kubernetes Secrets were used because they are simple and sufficient for a learning environment.
