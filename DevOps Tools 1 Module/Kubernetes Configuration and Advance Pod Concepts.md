# **Kubernetes Configuration and Advanced Pod Concepts**

This document covers advanced Kubernetes concepts, including **multi-container pods**, **replication controllers**, **deployments**, **daemon sets**, and various **configuration methods** like **config maps**, **secrets**, **resource settings**, and **service accounts**.

---

## **Topics to be discussed:**
1. Creating a Multi-Container Pod  
2. Replication Controller  
3. Deployment  
4. Daemon Set  
5. Configurations  
   - Config Maps  
   - Secrets  
   - Resource Settings  
   - Service Account  
6. Pod Scheduling  

---

# **Creating a Multi-Container Pod**

### **What is a Multi-Container Pod?**  
A **multi-container pod** is a Kubernetes pod that contains more than one container, allowing multiple tasks to run in **isolated containers** within a single pod.  
- **Use Case:**  
  - One container runs the application.  
  - Another container handles **logging**, **monitoring**, or **sidecar tasks**.

---

### **Why Use Multi-Container Pods?**  
- Separation of concerns: Each container performs a specific task.  
- Simplified configuration updates: Changes can be made to one container without affecting the other.

---

# **Replication Controller**

### **What is a Replication Controller?**  
A **Replication Controller** ensures that a **specified number of pod replicas** are running at any given time.  
- If a pod fails, it will automatically create a new one to maintain the desired state.

---

### **Difference Between Replica Set and Replication Controller**  

| **Replication Controller**             | **Replica Set**                               |
|----------------------------------------|-----------------------------------------------|
| Works on older Kubernetes versions.     | Introduced after Kubernetes v1.2.             |
| Basic functionality to manage replicas. | Supports **selectors** for better control.    |

---

### **Example Configuration**

**Replication Controller:**
```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: my-app
spec:
  replicas: 2
  selector:
    app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-container
          image: nginx
```

**Replica Set:**
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-container
          image: nginx
```

---

# **Deployment**

### **What is a Deployment?**  
A **Deployment** is a Kubernetes object that manages **replica sets** and **pods**.  
- It allows **scaling**, **self-healing**, **rolling updates**, and **rollbacks**.

---

### **Why Use Deployments?**  
1. **Scaling:** Easily scale the number of pod replicas.  
2. **Self-Healing:** Automatically replaces failed pods.  
3. **Rolling Updates:** Update pods with minimal downtime.  
4. **Rollbacks:** Revert to a previous version if something goes wrong.

---

### **Key Commands for Deployments**

| **Command**                          | **Description**                                 |
|--------------------------------------|-------------------------------------------------|
| `kubectl scale deploy/nginx --replicas=10` | Scales the deployment to 10 replicas.          |
| `kubectl rollout restart deploy <name>` | Restarts the deployment pods.                  |

---

# **Daemon Set**

### **What is a Daemon Set?**  
A **Daemon Set** ensures that a **pod is running on every node** in the cluster.  
- Commonly used for **monitoring** and **networking services**.

---

### **Use Cases for Daemon Sets**  
- **kube-proxy**: Manages networking for Kubernetes services.  
- **Log Collection**: Ensures logs are collected from every node.  
- **Security**: Runs security agents on each node.

**Daemon Set Example:**
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: my-daemonset
spec:
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-container
          image: nginx
```

---

# **Configurations**

## **Config Maps**

### **What is a Config Map?**  
A **Config Map** stores **non-confidential configuration data** in **key-value pairs**.  
- Helps decouple **configuration settings** from **application code**.

---

### **How to Create a Config Map?**

1. **Using CLI**:  
   ```bash
   kubectl create configmap my-config --from-literal=key=value
   ```

2. **Using YAML File**:  
   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: my-config
   data:
     key: value
   ```

3. **Using Environment Variables**:  
   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
     name: my-pod
   spec:
     containers:
       - name: my-container
         image: nginx
         envFrom:
           - configMapRef:
               name: my-config
   ```

---

## **Secrets**

### **What is a Secret?**  
A **Secret** stores **sensitive information** such as **passwords**, **tokens**, and **TLS certificates**.

---

### **Types of Secrets**

| **Type**              | **Description**                                |
|-----------------------|------------------------------------------------|
| **Opaque**            | Stores generic key-value pairs.                |
| **TLS**               | Stores **TLS certificates**.                   |
| **Docker-Registry**   | Stores **Docker credentials** for private images. |

---

### **How to Create a Secret?**

1. **Using CLI**:  
   ```bash
   kubectl create secret generic my-secret --from-literal=username=admin --from-literal=password=pass123
   ```

2. **Using YAML File**:  
   ```yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: my-secret
   type: Opaque
   data:
     username: YWRtaW4=  # Base64 encoded
     password: cGFzczEyMw==
   ```

---

## **Resource Settings**

### **What is Resource Setting?**  
Resource settings allow you to specify **CPU** and **memory** requests and limits for a pod.

---

### **Why Use Resource Settings?**  
1. **Ensure application performance**.  
2. **Prevent resource starvation** for other applications.  

---

### **Soft and Hard Evictions**

| **Type**       | **Description**                                     |
|----------------|-----------------------------------------------------|
| **Soft Eviction** | Gracefully terminates the pod when resources are low. |
| **Hard Eviction** | Forcefully removes the pod when the node runs out of resources. |

---

### **Pod Priority Example**

**Define a Priority Class**:  
```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000
globalDefault: false
description: "This is a high priority class"
```

**Use in a Pod**:  
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  priorityClassName: high-priority
  containers:
    - name: my-container
      image: nginx
```

---

# **Summary of Key Commands**

| **Command**                            | **Description**                                          |
|----------------------------------------|----------------------------------------------------------|
| `kubectl create configmap <name>`       | Creates a config map.                                    |
| `kubectl create secret generic <name>`  | Creates a generic secret.                                |
| `kubectl apply -f <file>`               | Applies a configuration file to the cluster.             |
| `kubectl scale deploy <name> --replicas=<number>` | Scales a deployment to the specified number of replicas. |
| `kubectl rollout restart deploy <name>` | Restarts the pods in a deployment.                       |

---

# **Conclusion**

In this session, we covered:  
- **Multi-Container Pods**: Managing multiple tasks within a single pod.  
- **Replication Controllers and Replica Sets**: Ensuring high availability of pods.  
- **Deployments**: For scaling, rolling updates, and rollbacks.  
- **Daemon Sets**: Running pods on all nodes.  
- **Configurations**: Using **Config Maps**, **Secrets**, and **Resource Settings**.
