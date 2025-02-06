# Kubernetes Observability and Pod Design

This document provides comprehensive lecture notes covering key concepts such as service accounts, pod scheduling, init containers, and effective pod design. It incorporates examples, use cases, and detailed explanations for instructors to teach effectively.

---

## Service Accounts

### Introduction to Service Accounts
- **Purpose**: Service accounts provide an identity to processes running within a pod, granting them specific permissions to interact with Kubernetes resources.
- **Example**: A pod running a web application that needs to read data from a ConfigMap would require a service account with the appropriate read permissions.

### Key Concepts
1. **Permissions and Namespace**:
   - Service accounts are tied to a specific namespace.
   - Resources like secrets and ConfigMaps are also namespace-scoped. If no namespace is specified, they are assigned to the `default` namespace.
   - Service accounts must be explicitly assigned to the same namespace as the resources they interact with.

2. **Creating a Service Account**:
   - Via CLI:  
     ```
     kubectl create serviceaccount <name_of_sa>
     ```
   - Via YAML:  
     ```yaml
     apiVersion: v1
     kind: ServiceAccount
     metadata:
       name: <name_of_sa>
       namespace: <namespace_name>
     ```

3. **Use Case**:
   - Assign permissions for pods to perform specific actions:
     - Pod A can read resources.
     - Pod B can read, write, and delete resources.

---

## Pod Scheduling to Nodes

### Introduction to Pod Scheduling
- Pod scheduling involves determining which node will host a pod. This ensures optimal resource usage and prevents conflicts or failures.
- **Example Scenario**:
  - Node1 has 20GB of memory.
  - Node2 has 100GB of memory.
  - A pod requiring 40GB of memory would fail to schedule on Node1 but succeed on Node2.

### Factors Influencing Pod Scheduling
1. **Resource Requests and Limits**:
   - Define how much CPU and memory a pod requests and caps its usage.

2. **Taints and Tolerations**:
   - **Taints**: Applied to nodes to restrict pods from scheduling unless they tolerate the taint.
   - **Tolerations**: Applied to pods to enable them to schedule on tainted nodes.
   - Effects of taints:
     - `NoSchedule`: Pods without toleration are not scheduled.
     - `PreferNoSchedule`: Avoid scheduling but not strictly enforced.
     - `NoExecute`: Evicts existing pods if they don’t tolerate the taint.
   - **Command Example**:
     ```
     kubectl taint nodes <node_name> <key>=<value>:NoSchedule
     ```
   - **Use Cases**:
     - Dedicated workloads.
     - Node maintenance.

3. **Node Selectors and Labels**:
   - Nodes and pods can be labeled with key-value pairs to match workloads to nodes.
   - **Commands**:
     - Labeling a node:  
       ```
       kubectl label nodes <node_name> instanceType=spot
       ```
     - Assigning a pod to a labeled node:  
       ```yaml
       nodeSelector:
         instanceType: spot
       ```

4. **Node Affinity**:
   - A flexible approach to scheduling pods on specific nodes based on rules.
   - **Key Differences**:
     - **Taints and Tolerations**: Block or isolate workloads.
     - **Node Selectors**: Require exact label matches.
     - **Node Affinity**: Supports both mandatory (`requiredDuringSchedulingIgnoredDuringExecution`) and preferred scheduling rules (`preferredDuringSchedulingIgnoredDuringExecution`).

| **Aspect**               | **Taints & Tolerations**               | **Node Selectors**                     | **Node Affinity**                      |
|--------------------------|----------------------------------------|----------------------------------------|----------------------------------------|
| **Purpose**              | Block pods unless tolerated            | Match labels strictly                  | Control placement with flexible rules  |
| **Flexibility**          | Strict                                 | Strict                                 | Flexible                               |
| **Configuration**        | `tolerations` in pod spec              | `nodeSelector` in pod spec             | `affinity` in pod spec                 |
| **Effect when unmatched**| Won't schedule                         | Won't schedule                         | May block or prefer scheduling         |


---

## Init Containers

### Overview of Init Containers
- **Definition**: Init containers run before the main application containers and are designed to complete specific initialization tasks.
- **Characteristics**:
  - They run sequentially and must complete successfully before the main container starts.
  - Multiple init containers run one after the other.

### Use Cases
1. Setting up configurations or preparing environment variables.
2. Verifying dependencies or required services.
3. Performing security checks or downloading initialization data.


---

## Pod Design and Observability

### Designing Pods with Dependencies
- Applications with dependencies must be designed such that:
  - Application1 only starts after Application2 completes.
  - Kubernetes ensures proper sequencing through tools like init containers and probes.

### Key Elements of Pod Design
1. **Probes**:
   - Liveness Probe: Ensures the container is running as expected.
   - Readiness Probe: Verifies the application is ready to serve requests.
   - Startup Probe: Confirms the application has started successfully.

2. **Labels, Selectors, and Annotations**:
   - Labels help organize and select specific pods or nodes.
   - Annotations provide metadata that doesn’t affect scheduling.

3. **Deployments and Services**:
   - Use Deployments to manage replicas and updates.
   - Services expose pods for network communication within or outside the cluster.

4. **Deployment Strategies**:
   - Rolling Updates: Incrementally update pods without downtime.
   - Blue-Green Deployments: Use separate environments for new and old versions.
---
