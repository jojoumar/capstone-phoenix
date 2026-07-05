# Runbook (fill this in — a teammate must rebuild from this alone)

## Provision from zero
```bash
cd infra/terraform
terraform init
terraform apply

cd ../ansible/k3s-ansible
ansible-playbook -i inventory.yml playbooks/site.yml

export KUBECONFIG=~/.kube/config

kubectl get nodes

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.yaml

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f gitops/taskapp-app.yaml
```

## Day-2 operations
- **Scale a tier:** kubectl scale deployment backend --replicas=3 -n taskapp
- **Roll back a bad deploy:** kubectl rollout undo deployment/backend -n taskapp
- **Run a new migration safely:** kubectl rollout restart deployment/backend -n taskapp
- **Rotate a secret:** kubectl delete secret backend-secret -n taskapp and kubectl create secret generic backend-secret ...

## Failure recovery (you'll demo one of these live)
- **A worker node dies / is drained:** kubectl drain worker1 \
--ignore-daemonsets \
--delete-emptydir-data

- **A backend Pod crashloops:** kubectl logs POD --previous
kubectl describe pod POD
kubectl get events

- **A bad migration:** If a migration fails, restore the database from backup or roll back the migration using Alembic before redeploying the backend.

- **Postgres Pod is rescheduled:** kubectl delete pod postgres-0 -n taskapp
