## Kubernetes API Versioning, K8s Extension , Certification Tip: Lecture Notes



##  Admission Controllers


### **Purpose:**
Admission controllers are plugins that enforce policies on objects being created or updated in a Kubernetes cluster. These policies are essential to maintain security, resource limits, and operational efficiency.

### **Types of Admission Controllers:**
1. **Mutating Admission Controller:**
   - Modifies requests to enforce certain policies before they are accepted into the cluster.
   - Example: Automatically adding labels to pods.

2. **Validating Admission Controller:**
   - Ensures requests meet certain criteria and validates configurations.
   - Example: Rejecting deployments with insecure configurations.

![image](https://hackmd.io/_uploads/SkOaSVgU1g.png)

### **Commonly Used Admission Controllers:**
| Controller         | Purpose                                              |
|--------------------|------------------------------------------------------|
| Namespace Lifecycle | Prevents operations on resources in non-existent namespaces |
| Limit Ranger        | Enforces default resource limits                    |
| Resource Quota      | Enforces quotas on the number of resources used     |

---

##  Kubernetes API Versions

### **Stages of API Versions:**
1. **Alpha:**
   - Experimental features.
   - May change or be removed in future releases.
   - **Not recommended** for production use.

2. **Beta:**
   - Features have broader testing.
   - Guaranteed not to be removed.
   - May have minor changes.

3. **Stable:**
   - Fully tested and ready for production.
   - No further breaking changes.
   - Example: `v1`.

### **Examples of Kubernetes API Versions:**
1. **v1:** Core stable API version including resources like:
   - Pods
   - Services
   - ConfigMaps

2. **Other API Groups:**
   - `apps/v1` for Deployments
   - `batch/v1` for Jobs and CronJobs

---

##  Kubernetes Resources and Autoscaling


### **Core Resources:**
1. **Pods:**
   - Smallest deployable units in Kubernetes.
   - Represents a group of containers with shared storage, network, and specifications.

2. **Services:**
   - Abstracts and exposes pods as network services.
   - Ensures stable communication between pods and users.

3. **ConfigMaps:**
   - Stores non-sensitive configuration data in a key-value format.

4. **Secrets:**
   - Stores sensitive data like passwords and tokens securely.

5. **Namespaces:**
   - Provides a mechanism to isolate groups of resources within a cluster.

6. **Persistent Volumes (PVs):**
   - Provides storage resources for pods, independent of their lifecycle.

### **Workload Resources (apps/v1, batch/v1):**
1. **Deployment:**
   - Manages replicated applications.
   - Supports rolling updates.

2. **ReplicaSet:**
   - Ensures a specified number of pod replicas are running at any time.

3. **StatefulSet:**
   - Manages stateful applications with stable network identities and persistent storage.

4. **DaemonSet:**
   - Ensures a copy of a pod runs on all or selected nodes in the cluster.

5. **Job:**
   - Manages batch jobs.
   - Ensures specified tasks are completed successfully.

6. **CronJob:**
   - Schedules jobs to run at specific times or intervals.

### **Networking Resources (networking.k8s.io):**
1. **Ingress:**
   - Manages external access to services within the cluster.
   - Acts as an HTTP/HTTPS proxy.

2. **Network Policy:**
   - Controls traffic flow between pods.
   - Example: Allowing only specific pods to communicate.

3. **Service:**
   - Exposes a set of pods and ensures stable networking.

### **Storage Resources:**
1. **Storage Class:**
   - Defines different types of storage and policies for dynamic provisioning.

### **RBAC & Authorization:**
Kubernetes provides **Role-Based Access Control (RBAC)** to manage permissions.

**API Group:** `rbac.authorization.k8s.io`

**Resources:**
1. **Roles:**
   - Assign permissions within a namespace.

2. **Role Bindings:**
   - Binds roles to users or groups within a namespace.

3. **Cluster Roles:**
   - Assign permissions cluster-wide.

4. **Cluster Role Bindings:**
   - Binds cluster roles to users or groups cluster-wide.

### **Custom Resources:**
1. **Custom Resource Definition (CRD):**
   - Extends the Kubernetes API.
   - Allows users to define and use their own resources.

---

##  Autoscaling
Kubernetes provides tools to automatically adjust resources based on usage.

1. **Horizontal Pod Autoscaler (HPA):**
   - Scales pods horizontally based on CPU or custom metrics.

2. **Vertical Pod Autoscaler (VPA):**
   - Adjusts resource requests and limits for containers based on actual usage.

---

##  Key Commands (kubectl)


### **Basic Pod Commands:**
1. `kubectl get pods -o wide`
   - Displays detailed pod information in a wide format.

2. `kubectl get pods -o json`
   - Outputs pod details in JSON format.

3. `kubectl get pods --field-selector=status.phase=Running`
   - Filters pods based on their running status.

4. `kubectl get pods --watch`
   - Watches for changes in pod status in real-time.

### **Aliases:**
1. `alias kgp='kubectl get pods'`
   - Shortens the command to list pods.

### **Other Commands:**
1. `kubectl exec`
   - Executes commands directly within a container.

---

## **Examples for Better Understanding:**
1. **Mutating Admission Controller Example:**
   - Automatically adding a label to pods using `MutatingWebhookConfiguration`.

2. **Validating Admission Controller Example:**
   - Ensuring deployments do not use `latest` tag for images.

3. **API Version Usage Example:**
   - Using `apps/v1` for deploying a sample application.

---
