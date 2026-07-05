## Monthly itemized cost
|| Item          | Qty |           Cost |
| ------------- | --: | -------------: |
| Control Plane |   1 |            $16 |
| Worker 1      |   1 |            $16 |
| Worker 2      |   1 |            $16 |
| EBS Storage   |   3 |             $3 |
| Domain        |   1 |             $1 |
| Total         |     | **≈$52/month** |


## Compared to Docker Compose
Single VM:

≈ $16/month

Kubernetes cluster:

≈ $52/month

## What the extra money buys
High Availability
Automatic Scheduling
Rolling Updates
GitOps
Self Healing
Horizontal Scaling
Persistent Storage
Better fault tolerance

## How I'd halve this
For a development environment, I would reduce the worker nodes to one or use smaller t3.micro instances. Spot instances could also be used for workers to significantly reduce compute costs while retaining the Kubernetes architecture.
