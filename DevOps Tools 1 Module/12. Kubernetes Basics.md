# **Kubernetes Basics**

This document provides a comprehensive introduction to **Kubernetes**, covering key concepts such as **multinode clusters**, **kubeconfig**, **namespaces**, and **pods**. It also explains the **pod lifecycle**, potential pod issues, and troubleshooting tips.

---

## **Topics to be discussed:**
1. Multinode Cluster  
2. Kubeconfig  
3. Namespace  
4. Pods  
5. Replica Controllers and Replica Sets  
6. Deployments  
7. Daemon Sets  

---

# **Multinode Cluster and Kubeconfig**

### **What is a Multinode Cluster?**

A **multinode cluster** in Kubernetes consists of:  
- **Master Nodes** (Control Plane): Responsible for managing the cluster and scheduling workloads.  
- **Worker Nodes**: Responsible for running containerized workloads (pods).  

---

### **Cluster Setup in Dev vs. Prod**

- **Development/QA/Practice Environments**:  
  - Master and worker nodes can run as **containers** on a **single virtual machine** to save costs.  
  - Example: Using **Kind** (Kubernetes in Docker).

- **Production Environment**:  
  - Each **master node** and **worker node** runs on **separate virtual machines**, increasing **cost** but providing **high availability** and **fault tolerance**.

**Diagram:**  
![Multinode Cluster](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/101/374/original/eks.png?1735472738)

---

### **Creating a Multinode Cluster Using Kind**

1. **Create a `multi-node.yml` file** to define the cluster configuration:  
   ```yaml
   kind: Cluster
   apiVersion: kind.x-k8s.io/v1alpha4
   nodes:
     - role: control-plane
     - role: worker
     - role: worker
   ```

2. **Create the cluster**:  
   ```bash
   kind create cluster --name multi-node-cluster --config=multi-node.yml
   ```

---

### **What is Kubeconfig?**

- **Kubeconfig** is a **configuration file** used to access Kubernetes clusters.  
- It contains information about **clusters**, **users**, and **contexts**.  
- **Default Location**:  
  ```bash
  ~/.kube/config
  ```

---

# **Namespaces**

### **What is a Namespace?**

A **namespace** is a way to **organize and isolate resources** within a Kubernetes cluster.  
- It allows multiple teams or applications to share the same cluster without interference.  
- **Resource quotas** can be applied to namespaces to limit resource usage.

---

### **Types of Namespaces**

| **Namespace**      | **Description**                                       |
|--------------------|-------------------------------------------------------|
| **default**        | The default namespace for resources without a specified namespace. |
| **kube-system**    | Contains **system resources** created by Kubernetes.   |
| **kube-public**    | A **readable namespace** for all users.                |
| **kube-node-lease**| Used for **node heartbeat** data.                      |

---

### **Creating a Namespace**

1. **Create a `namespace.yml` file**:  
   ```yaml
   apiVersion: v1
   kind: Namespace
   metadata:
     name: my-namespace
   ```

2. **Apply the file to create the namespace**:  
   ```bash
   kubectl apply -f namespace.yml
   ```

---

### **Creating a Pod in a Custom Namespace**

1. **Create a `pod_custom_ns.yml` file**:  
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: my-pod
     namespace: my-namespace
   spec:
     containers:
       - name: my-container
         image: nginx
   ```

2. **Apply the file**:  
   ```bash
   kubectl apply -f pod_custom_ns.yml
   ```

3. **Alternatively, create a pod with a command**:  
   ```bash
   kubectl run my-pod-with-command --image=nginx --namespace=my-namespace
   ```

---

### **Resource Quotas in Namespaces**

- You can set **resource quotas** to limit the number of resources (pods, CPU, memory) in a namespace.  
- **Check resource quotas** for a namespace:  
   ```bash
   kubectl get resourcequota -n my-namespace
   ```

---

# **Pods**

### **What is a Pod?**

A **Pod** is the **smallest deployable unit** in Kubernetes.  
- A pod can contain **one or more containers** that share **networking** and **storage**.

---

### **Pod Lifecycle Stages**

| **Stage**               | **Description**                                               |
|-------------------------|---------------------------------------------------------------|
| **Pending**             | The pod is created but hasn't been scheduled on a node yet.    |
| **ContainerCreating**   | The container inside the pod is being created.                |
| **Running**             | The pod is running at least **one container**.                |
| **Error**               | The pod encountered an error during creation or execution.     |

---

### **Reasons for a Pod to Be in Pending State**

1. **Insufficient Resources**  
   - The node doesn't have enough CPU or memory.  

2. **Issues with Label Selectors or Taint Tolerances**  
   - The pod can't find a suitable node due to **node labels** or **taints**.

3. **Image Pull Issues**  
   - **ImagePullBackOff** or **ErrImagePull** occurs due to:  
     - Incorrect image name.  
     - Access or authentication issues.  
     - Network problems.

4. **CrashLoopBackOff**  
   - The container inside the pod **keeps crashing** and restarting.  
   - Common causes:  
     - **Application issues**.  
     - **Misconfigurations**.

5. **OOMKilled (Out of Memory Killed)**  
   - The container **exceeds its memory limit** and is terminated.

6. **CreateContainerConfigError**  
   - Errors related to **config maps**, **secrets**, or **volumes**.

---

### **How to Debug a Pod?**

1. **Describe the Pod**  
   ```bash
   kubectl describe pod <pod_name>
   ```
   - Provides detailed **event logs** for the pod.

2. **Check Pod Logs**  
   ```bash
   kubectl logs -f <pod_name>
   ```
   - Use this to **tail logs** of a running container.  
   - **Note:** Logs won't be available for pods in **Pending** state.

---

### **Pod Creation Process: Revisiting Kubernetes Architecture**

1. **Apply the Pod Configuration**:  
   ```bash
   kubectl apply -f pod.yml
   ```

2. **API Server**:  
   - **Validates** the configuration and stores it in **etcd** (a distributed key-value store).

3. **Controller Manager**:  
   - Detects changes in the **desired state** and takes action to create pods.

4. **Scheduler**:  
   - **Schedules** the pod on a suitable node.

5. **Kubelet**:  
   - The **Kubelet** on the selected node **starts the container**.

6. **Kube Proxy**:  
   - Manages **networking** between pods on different nodes.

---

### **Pod Lifecycle Architecture Diagram**  
![Pod Lifecycle](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/101/655/original/podlifecycle.png?1735733983)

---

# **Key Kubernetes Commands Recap**

| **Command**                               | **Description**                                  |
|-------------------------------------------|--------------------------------------------------|
| `kubectl apply -f <file>`                 | Apply a configuration file.                     |
| `kubectl get pods`                        | List all pods.                                  |
| `kubectl describe pod <pod_name>`         | Show detailed information about a pod.          |
| `kubectl logs -f <pod_name>`              | Stream logs from a pod.                         |
| `kubectl get namespaces`                  | List all namespaces.                            |
| `kubectl run <pod_name> --image=<image>`  | Create a pod with a specific image.             |

---

# **Conclusion**

In this session, we discussed:  
- **Multinode Clusters**: How to set up clusters for different environments.  
- **Kubeconfig**: The configuration file that stores cluster access details.  
- **Namespaces**: How to organize and manage resources in Kubernetes.  
- **Pods**: The smallest deployable unit in Kubernetes and its lifecycle stages.  
