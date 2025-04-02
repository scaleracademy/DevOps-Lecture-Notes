# Typed Notes - Class7 - Advanced ArgoCD Usage and Configuration

---
title: Agenda of the lecture
description: Recap of last class and topics to be discussed in today's class
duration: 240
card_type: cue_card
---

- **Recap of Previous Class**
  - Introduction to GitOps.
  - Argo CD
  - Installation of Argo CD.
  - Creation of the first application using GUI.

- **Agenda for Today**
    - **Creating an Application**
       - Using **Custom Resource Definitions (CRD)**.
       - Implementation via **YAML**.
    - **Argo CD Architecture**
    - **Managing Argo CD using Argo CD**
    - **App in App Concept**

---
title:Understanding application deployment 
description: YAML based Application creation and using Argo CD
duration: 2500
card_type: cue_card
---

### **Understanding Application Deployment in Kubernetes**
- **In the last class:**
  - Created an application.
  - The application created a **Custom Resource Definition (CRD)** in Kubernetes.

- **Deployment in Kubernetes:**
  - Traditionally done via **YAML files**.
  - YAML files are used for:
    - **Deployments**.
    - **Services**.
    - **Exposing services (GUI, etc.)**.

- **GUI-based Deployment in ArgoCD:**
  - GUI was used to create a **Custom Resource**.
  - YAML file for the resource can be retrieved using:
    ```
    kubectl describe application <application_name> -o yaml
    ```
  - Kubernetes supports the **reverse process**:
    - If an application is created via GUI, its YAML can still be extracted.
    - Similarly, YAML can be used to create a CRD without using GUI.

### **Why YAML-based Deployment is Preferred?**
- GUI is **not scalable** for large-scale automation.
- Managing multiple applications is **simpler via code**.
- **Automation & efficiency**:
  - GUI makes automation difficult.
  - YAML-based management allows for **Infrastructure as Code (IaC)**.

## **Exposing Argo CD**
- **Ways to Access Argo CD UI:**
  1. **Expose Service via Load Balancer** (Permanent solution, but costly).
  2. **Port Forwarding** (Temporary, cost-saving solution).
        ```
        kubectl port-forward svc/argocd-server -n argocd 8443:443
        ```
        - Maps **port 443 (Kubernetes)** → **port 8443 (local machine)**.
        - Allows access to the **Argo CD dashboard** via:
      ```
      https://localhost:8443
      ```

    - **Alternative: Running in Background**
      - Use `&` at the end of the command:
        ```
        kubectl port-forward svc/argocd-server -n argocd 8443:443 &
        ```
      - If needed, kill the process using:
        ```
        ps -aux | grep port
        ```   
    ![image](https://hackmd.io/_uploads/H1f5obiF1g.png)
     - A **Vault service** manages secrets.
     - Need to check stored secrets **without exposing it publicly**.
     - Use `port-forward` to access it temporarily.


### **Creating an Application Using YAML**
- Used **Argo CD Example Repository** from GitHub. [Link](github.com/argoproj/argocd-example-apps) 
- Repository contains **helm-guestbook** example.
   ```
    vi helm-guestbook-app.yml
    k apply -f helm-guestbook-app.yml
    k get application -A
   ```
  - **Structure**:
    ```
    helm-guestbook/
      ├── charts/
      ├── values.yaml
      ├── Chart.yaml
    ```
  - Argo CD can **automatically detect the deployment type**:
    - If `Chart.yaml` exists → **Helm Deployment**.
    - If `kustomization.yaml` exists → **Kustomize Deployment**.
    - If only YAML files exist → **Plain Kubernetes YAML Deployment**.
- **Application Configuration:**
  ```yaml
  apiVersion: argoproj.io/v1alpha1
  kind: Application
  metadata:
    name: helm-guestbook
  spec:
    project: default
    source:
      repoURL: "https://github.com/example/argocd-example"
      path: "helm-guestbook"
    destination:
      server: "https://kubernetes.default.svc"
      namespace: default
    syncPolicy:
      automated:
        prune: true
        selfHeal: true
  ```
- **Explanation:**
  - **repoURL** → Specifies the Git repository.
  - **path** → Specifies the directory containing the application.
  - **destination** → Defines where the application will be deployed.
  - **syncPolicy**:
    - `automated: true` → Enables automatic synchronization.
    - `prune: true` → Allows **automatic deletion** of outdated resources.
    - `selfHeal: true` → Ensures desired state is maintained.
- Applying the YAML:
  ```
  k apply -f application.yaml
  ```
- We discussed 2 examples:
    - 1. GUI-based Application Creation (Manual sync)
    - 2. YAML-based Application Creation (Automated sync)
        - Preferred in production
---
title: Argo CD Architecture
description: Understanding Arog CD components and flow
duration: 1500
card_type: cue_card
---

### **Core Components:**
1. **Argo CD API Server**
   - The main entry point for users.
   - Handles API requests from:
     - **CLI**
     - **Web UI**
     - **External systems (e.g., CI/CD tools)**.

2. **Repository Server**
   - Fetches application configurations from **Git**.
   - Maintains a **local cache** of repositories.
   - Converts Helm charts into Kubernetes manifests.

3. **Application Controller**
   - Ensures the **actual cluster state matches the desired state**.
   - Applies Kubernetes manifests generated by **Repo Server**.

4. **Redis (Cache)**
   - Stores temporary data to **reduce redundant operations**.
   - Prevents multiple applications from repeatedly fetching the same Helm charts.

### **Flow of Operations in Argo CD**
1. **User interacts with API Server** (via UI, CLI, or external tools).
2. **Repo Server fetches configuration** from Git.
3. **Application Controller applies the configurations** to Kubernetes.
4. **Redis caches results** to improve performance.


---
title: Self-Managed Argo CD
description: Practical Demonstration of Self-Managed Argo CD
duration: 1800
card_type: cue_card
---

### **Why Do We Need Self-Management?**
- **Argo CD manages Kubernetes, but who manages Argo CD?**
  - If Argo CD’s configurations **are deleted**, it affects **all applications**.
  - **Solution: Argo CD should manage itself** using GitOps principles.

### **Analogy: Chef & Recipe Book**
- **Chef (Argo CD)** reads the **recipe book (Git)** to prepare **dishes (Kubernetes applications)**.
- What if **instructions for the chef himself** were in the same **recipe book**?
  - **Chef knows:**
    - What time to start cooking.
    - What ingredients to use.
    - How to maintain the kitchen.
  - **Similarly, Argo CD can read its own configuration from Git.**
    - This is called **self-management**.

### **How Self-Management Works?**
1. **Define Argo CD’s own configuration as an application** inside Git.
2. **Argo CD applies those settings to itself**.
3. **If someone modifies or deletes configurations manually, Argo CD restores them**.

- **Advantages:**
  - **Prevents accidental deletions**.
  - **Ensures consistency across clusters**.
  - **Follows GitOps principles** for managing Argo CD itself.

# **Practical Demo: Self-Managed Argo CD**
### **Step 1: Creating a Helm Chart for Argo CD**
- Used the following command to create a Helm chart:
  ```bash
  helm create ArgoCD-self-managed
  ```
- This command **generates a default directory structure** containing:
  - `charts/`
  - `values.yaml`
  - `Chart.yaml`
  - `templates/`
  - Default Kubernetes manifests.
- This Helm chart **defines Argo CD’s own configuration**, allowing Argo CD to manage itself.


### **Step 2: Updating Chart.yaml and Values.yaml**
- **Chart.yaml**:
  - Added details about **Argo CD’s self-management**.
  - Defined the **Git repository** where the configuration is stored.

- **Values.yaml**:
  - Customized resources as needed:
    - Controller CPU: **500m**
    - Controller Memory: **256Mi**

### **Step 3: Creating an Argo CD Application YAML**
- Created an **application.yaml** file that defines how Argo CD will manage itself.
  ```yaml
  apiVersion: argoproj.io/v1alpha1
  kind: Application
  metadata:
    name: argocd-self-managed
  spec:
    project: default
    source:
      repoURL: "https://github.com/user/argocd-self-managed"
      path: "helm"
      targetRevision: main
    destination:
      server: "https://kubernetes.default.svc"
      namespace: argocd
    syncPolicy:
      automated:
        prune: true
        selfHeal: true
  ```
- Points to the **Git repository** where Argo CD’s configuration exists.
- **SyncPolicy:**
    - **prune: true** → Deletes outdated resources.
    - **selfHeal: true** → Ensures manual changes are reverted.


### **Step 4: Deploying the Self-Managed Argo CD**
- **Helm Install**:
  ```bash
  helm upgrade --install argocd-self-managed ./ArgoCD-self-managed --namespace argocd
  ```
- **Applying the Application YAML:**
  ```bash
  kubectl apply -f application.yaml
  ```
- **Expected Outcome:**
  - Argo CD **registers itself as an application**.
  - It starts **monitoring and managing its own configurations**.
  
 
## **Key Learnings from the Demo**
### **1. Manual Changes vs Self-Managed Argo CD**
- Before **self-management**, you could **manually edit Argo CD resources**.
- After **self-management**, any manual change is **reverted** unless committed to Git.

- **Example:**
  - Increasing Argo CD replica count from **1 to 2** manually:
    ```bash
    kubectl scale deployment argocd-server --replicas=2 -n argocd
    ```
  - With **self-management enabled**, Argo CD **detects the change and reverts it**.

### **2. The Need for Pre-Patching Helm Resources**
- **Issue:**
  - When installing Argo CD via Helm, existing resources **may conflict**.
- **Solution:**
  - Apply **Helm ownership patches**:
    ```bash
    kubectl patch serviceaccount <name> -n argocd --type merge -p '{"metadata":{"annotations":{"meta.helm.sh/release-name":"argocd-self-managed"}}}'
    ```
    - Ensures Helm **takes control** of existing resources.
    - Similar patches were applied to:
      - **Secrets**
      - **ConfigMaps**
      - **Custom Resources (CRDs)**.


### Question: Should We Use the Same Repository or Separate Repositories?
- Both approaches are valid, choose based on team structure & security needs:
- **Same Repo Approach**:
    - **Advantages**:
      - Centralized management.
      - Easier to track **infrastructure & application changes together**.
    - **Disadvantages**:
      - More complex access controls (developers shouldn’t modify Argo CD configs).
- **Separate Repo Approach**:
    - **Example**:
      - `git@github.com:company/argocd-config.git`
      - `git@github.com:company/applications.git`
    - **Advantages**:
      - Better separation of concerns.
      - Dev teams manage applications, Ops teams manage Argo CD.
    - **Disadvantages**:
      - Extra **repository maintenance overhead**.
