# Kubernetes Core Concepts


## Agenda of the Lecture

### Today's Discussion Topics
- **Why Kubernetes?**
- **Kubernetes (K8s) Architecture**
- **Different Types of K8s**
- **Demo**
- **Kubectl**


## Why Kubernetes?

### Key Points:
- Kubernetes is abbreviated as **K8s**, with 8 letters between K and s.
- Evolution:
  1. Physical Machines: One application per machine.
  2. Virtual Machines (VMs): Multiple isolated applications per physical machine.
  3. Containers: Running multiple independent applications within VMs using Dockerization.
- Challenges with Scaling:
  - Increased number of containers leads to increased complexity.
  - Orchestration became necessary to manage containers.
- Kubernetes (K8s):
  - Acts as a **container orchestration tool**.
  - Dynamically assigns resources (containers) based on demand, e.g., in an e-commerce platform.
  - Benefits:
    - **Scalability**
    - **Reliability**
    - **Resource Efficiency**


## Kubernetes (K8s) Architecture

### Overview:
- Divided into:
  - **Control Plane**
  - **Worker Nodes**

### Control Plane:
- Manages the entire Kubernetes cluster and takes high-level decisions.
- Components:
  - **API Server**: Central communication hub for users and nodes.
  - **ETCD**: A distributed key-value store; acts as the cluster's database.
  - **Scheduler**: Decides the placement of pods across nodes.
  - **Control Manager**: Ensures the desired state of the cluster using various controllers.

### Worker Nodes:
- Responsible for executing the tasks.
- Components:
  - **Kubelet**: Ensures containers in the node are running as defined.
  - **Pods**:
    - Smallest unit in Kubernetes where containers run.
    - Pods have IPs, not containers.
  - **CRI (Container Runtime Interface)**: Software responsible for running containers (e.g., Docker).
  - **Kube Proxy**: Manages networking within the cluster.

### Architectural Analogy:
- **Control Plane**: Brain (decision-making).
- **Worker Nodes**: Body parts (execution).


## Types of Kubernetes

### Categories:
1. **Vanilla Kubernetes**:
   - Open-source and highly customizable.
2. **Kubernetes for Developers**:
   - Tools like Kind, Minikube, and Micro K8s for local environments.
3. **Managed Kubernetes Services**:
   - Cloud-based solutions like GKE, EKS, AKS, IBM Kubernetes Service, and Oracle Kubernetes Engine.


## Installation and Practical Demo

### Installing Kubernetes:
1. Install Kind:
   ```bash
   curl -Lo ./kind https://kind.sigs.k8s.io/d1/v0.14.0/kind-linux-amd64
   chmod +x ./kind
   sudo mv ./kind /usr/local/bin/kind
   kind --version
   kind create cluster --name my-cluster
   ```
2. Install Kubectl:
   ```bash
   sudo apt-get update
   sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
   sudo mkdir -p -m 755 /etc/apt/keyrings
   sudo apt-get install -y kubectl
   ```

### Kubectl Commands:
- Check cluster info:
  ```bash
  kubectl cluster-info dump
  ```
- Node details:
  ```bash
  kubectl describe nodes kind-control-plane
  ```
- Other Commands:
  - `kubectl get nodes`: Lists all nodes.
  - `kubectl get pods -A`: Lists all pods across namespaces.
