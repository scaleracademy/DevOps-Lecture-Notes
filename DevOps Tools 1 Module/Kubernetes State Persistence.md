# Kubernetes State Persistence

---





## Network Policies



### **Overview:**
Network policies define rules for how pods communicate with:
- Each other.
- External endpoints.

Policies can manage both **ingress** (incoming traffic) and **egress** (outgoing traffic).

### **Key Concepts:**
1. **Selectors:**
   - Used to identify the pods to which the policy applies.
   - Example: A policy might target pods labeled `app=frontend`.
   - **Example:** Consider a microservices architecture where you only want the `frontend` pod to communicate with the `backend` pod but restrict it from accessing the `database` pod. Using selectors, you can define this scope effectively.

2. **Ingress Rules:**
   - Define the allowed incoming traffic to pods.
   - Example: Allow HTTP traffic on port 80 from a specific pod group.
   - **Example:** If a `shopping-cart` pod accepts traffic from a `user-session` pod, the ingress rule can specify that only requests on port 8080 (HTTP) are allowed while blocking others.

3. **Egress Rules:**
   - Define the allowed outgoing traffic from pods.
   - Example: Allow outgoing requests to a database pod.
   - **Example:** A `logging` pod might need to send data to an external monitoring service. The egress rule can restrict traffic to only the specific IP address of that service.

4. **Policy Types:**
   - **Ingress:** Rules for incoming traffic.
   - **Egress:** Rules for outgoing traffic.
   - Both can be used simultaneously to create comprehensive traffic policies.
   
 ![image](https://hackmd.io/_uploads/HkazMxsrJg.png)

### **Lab Workflow:**
1. **Deploy an Application:**
   - Example: Deploy a web application that communicates with a database pod.
   - **Example:** Deploy a `frontend` service that interacts with both a `backend` service and a `cache` service while limiting communication to specific ports and protocols.

2. **Deploy a Second Pod with Specific Policies:**
   - Create a pod with policies to allow only certain traffic.
   - Example: Deploy a monitoring pod that only listens to logs from the application pod.

3. **Create an Allow Policy:**
   - Example: Permit HTTP traffic from pod `frontend` to pod `backend`.
   - **Example:** Create a policy to allow TCP connections from a `worker` pod to a `queue` pod only on port 5672 for message queueing.

4. **Create a Deny Policy:**
   - Example: Block all other traffic except necessary requests.
   - **Example:** Deny all outbound traffic from a `debug` pod except for SSH connections to a specific admin server.

---

## Volumes in Kubernetes



### **Types of Volumes:**
1. **ConfigMap as Volume:**
   - Mount configuration data as files or environment variables.
   - Example: Store database connection strings in a `ConfigMap` and use it in pods.
   - **Detailed Example:** A `ConfigMap` containing multiple configurations (e.g., environment-specific variables for dev, staging, and production) can be mounted as a volume, ensuring consistent deployment across environments.

2. **Secret as Volume:**
   - Store sensitive data like passwords or tokens securely.
   - Example: Mount an API token secret as a volume.
   - **Example:** Use a `Secret` to store TLS certificates for a secure connection between pods.

3. **HostPath:**
   - Maps a directory or file on the host node’s filesystem to a pod.
   - Example: Use host paths to share logs between the host and pod.
   - **Example:** Map a specific directory, such as `/var/logs/app`, from the host node to a pod for real-time log monitoring.

4. **EmptyDir:**
   - A temporary directory created when a pod is assigned to a node.
   - Data is cleared when the pod stops.
   - Example: Cache data processing results temporarily.
   - **Example:** Use `EmptyDir` for temporary storage in a data analytics pipeline where intermediate results need to be processed within the same pod lifecycle.

![image](https://hackmd.io/_uploads/rkyK7gorye.png)

---

## Persistent Volumes (PV), Claims (PVC), and Storage Classes



### **Persistent Volumes (PV):**
- **Independent of Pod Lifecycle:** Persistent storage remains even after pod deletion.
- **Access Modes:**
  - **ReadWriteOnce:** Mounted by a single node for read/write.
  - **ReadOnlyMany:** Mounted by multiple nodes as read-only.
  - **ReadWriteMany:** Mounted by multiple nodes for read/write.

#### **Reclaim Policies:**
- **Retain:** Keeps the data for manual reclamation.
- **Recycle:** Performs a basic cleanup (e.g., deleting files).
- **Delete:** Deletes the data when the volume is released.

### **Persistent Volume Claims (PVC):**
- A request for storage by a pod.
- **Dynamic Provisioning:** Automatically provisions a PV when a PVC is created.

### **Storage Class:**
1. **Provisioner:** The backend storage responsible for provisioning.
2. **Parameters:** Define properties like storage size or type.
3. **Reclaim Policy:** Configured at the storage class level.

#### **Example Workflow:**
1. Define a **Storage Class** with specific parameters.
   - Example: Create a storage class for SSD-backed storage with high IOPS for database workloads.
2. Create a **PVC** to request storage from the defined class.
   - Example: Request a 10GB volume with `ReadWriteMany` access mode for shared access.
3. Automatically provision a **PV** based on the request.
4. Mount the PV to the pod for data persistence.
   - Example: Mount a dynamically provisioned PV to a MySQL pod for data storage.

---

## Quality of Service (QoS)



### **Goals:**
- Efficient resource management.
- Classify workloads based on resource requests and limits.

### **QoS Classes:**
1. **Guaranteed:**
   - Resources are fully reserved for the pod.
   - Example: A pod with exact resource requests and limits specified.
   - **Example:** Deploy a critical financial transaction processing pod with CPU and memory requests of 2 cores and 4GB respectively, ensuring consistent performance.

2. **Burstable:**
   - Some resource limits are set, but the pod can exceed requests.
   - Example: A pod with higher limits than requests.
   - **Example:** A `logging` pod with 500m CPU and 1GB memory requests but limits of 1 CPU and 2GB memory can burst when additional resources are available.

3. **BestEffort:**
   - No resource limits or requests specified.
   - Example: A pod that consumes resources only if available.
   - **Example:** Deploy an auxiliary data analysis pod without resource reservations, utilizing idle cluster resources.

---
