# Typed Notes- Class6- Introduction to GitOps and ArgoCD Setup Notes

GitOps is a modern approach to managing infrastructure and application configurations, emphasizing version control, automation, and declarative management. Argo CD is a tool that implements GitOps principles for Kubernetes deployments. Below is a comprehensive guide detailing GitOps, its principles, and the setup and usage of Argo CD.

---

**Table of Contents**

1. Introduction to GitOps
   - Limitations of Traditional CI/CD Tools
   - What is GitOps?
   - Key Principles of GitOps
2. Introduction to Argo CD
   - Continuous Integration (CI) vs. Continuous Deployment (CD)
   - What is Argo CD?
   - Push vs. Pull Deployment Models
3. Setting Up Argo CD
   - Prerequisites
   - Installation Steps
4. Deploying Applications with Argo CD
   - Defining Applications
   - Syncing Applications
   - Monitoring and Management
5. Benefits of GitOps and Argo CD

## Introduction to GitOps

### Limitations of Traditional CI/CD Tools

Traditional CI/CD tools like Jenkins have been instrumental in automating software development processes. However, they present certain challenges when it comes to deployment:

- **Manual Changes Tracking**: If someone manually modifies a Kubernetes deployment (e.g., changing the number of replicas), Jenkins does not detect or track these changes.

- **Human Error Potential**: Jenkins may not validate incorrect parameters, leading to potential deployment issues.

- **Multiple Configuration Sources**: Configurations can come from various sources, including Git repositories, Jenkins itself, and manual edits, leading to inconsistencies.

- **Lack of Deployment Tracking**: Jenkins facilitates deployments but does not ensure that the deployed state matches the desired state defined in version control.

### What is GitOps?

GitOps is a methodology that uses Git as the single source of truth for infrastructure and application configurations. In GitOps, any change, regardless of its size, must be stored and tracked in a Git repository. Deployments to production are only permitted if the changes are present in the Git repository.

### Key Principles of GitOps

1. **Declarative Descriptions**:
   - Infrastructure and configurations are defined using declarative syntax, typically in YAML files.
   - Kubernetes manifest files specify the desired state of the system.

2. **Version Control**:
   - Every change is stored in Git, ensuring the ability to roll back to previous states if necessary.
   - Maintains a history of all changes for auditing purposes.

3. **Continuous Reconciliation**:
   - The Kubernetes cluster is continuously checked against the desired state defined in Git.
   - If there is a drift between the actual state and the desired state, GitOps tools like Argo CD synchronize the cluster to match the desired state.

4. **Security and Compliance**:
   - No manual changes are allowed in production environments.
   - Ensures that all changes are auditable and traceable, enhancing security and compliance.

---

## Introduction to Argo CD

### Continuous Integration (CI) vs. Continuous Deployment (CD)

- **Continuous Integration (CI)**:
  - Involves fetching code from repositories like GitHub.
  - Building the code and running tests.
  - Pushing Docker images to repositories.

- **Continuous Deployment (CD)**:
  - Focuses on deploying applications to environments like Kubernetes.
  - Argo CD automates the deployment process, ensuring that the deployed state matches the desired state defined in Git.

### What is Argo CD?

Argo CD is a declarative, GitOps-based continuous delivery tool for Kubernetes. It ensures that the applications deployed in a Kubernetes cluster match the configurations defined in a Git repository.

### Push vs. Pull Deployment Models

- **Push Model (e.g., Jenkins)**:
  - Fetches configurations from GitHub.
  - Pushes the configurations to the Kubernetes cluster.

- **Pull Model (e.g., Argo CD)**:
  - Continuously monitors the Git repository for changes.
  - Pulls the changes and applies them to the Kubernetes cluster, ensuring synchronization between the Git repository and the cluster.

---

## Setting Up Argo CD

### Prerequisites

Before setting up Argo CD, ensure you have the following:

- **Kubernetes Cluster**: A running Kubernetes cluster.

- **kubectl CLI**: The Kubernetes command-line tool installed on your system.

- **Helm Package Manager**: Helm installed for managing Kubernetes applications.

### Installation Steps

1. **Install Docker**:
   - Update your package list and install Docker.
   - Add your user to the Docker group to manage Docker as a non-root user.

2. **Install Kubernetes (Minikube)**:
   - Download and install Minikube, a tool for running Kubernetes locally.
   - Start the Minikube cluster.

3. **Install `kubectl`**:
   - Download and install the `kubectl` CLI to interact with your Kubernetes cluster.

4. **Install Helm**:
   - Download and install Helm, the package 
manager for Kubernetes.  
   - Add the necessary Helm repositories for Argo CD.  

5. **Install Argo CD using Helm**:
   - Create a dedicated namespace for Argo CD:
     ```bash
     kubectl create namespace argocd
     ```
   - Install Argo CD using Helm:
     ```bash
     helm install argocd argo/argo-cd --namespace argocd
     ```
   - Verify the installation:
     ```bash
     kubectl get pods -n argocd
     ```

6. **Access the Argo CD UI**:
   - **Port-forwarding method**:
     ```bash
     kubectl port-forward svc/argocd-server -n argocd 8080:443
     ```
   - **Retrieve the admin password**:
     ```bash
     kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
     ```
   - **Login to the Argo CD UI** using:
     - **Username**: `admin`
     - **Password**: (retrieved from the previous command)

---

## **Deploying Applications with Argo CD**

### **1. Defining Applications**
- **Argo CD uses Applications** to manage deployments.
- **Applications are defined declaratively** in Git and Argo CD automatically reconciles them with the Kubernetes cluster.

### **2. Creating an Application in Argo CD**
- Navigate to **Applications → New Application** in the UI.
- **Specify the application details**:
  - **Application Name**: (e.g., `my-app`)
  - **Project**: Use `default` or create a new project.
  - **Sync Policy**:
    - **Manual**: Requires the user to trigger deployments.
    - **Automatic**: Deploys changes as soon as they are committed to Git.

### **3. Configuring the Git Repository**
- **Repository URL**: Add the URL of the Git repository.
- **Branch**: Choose `main` or another branch.
- **Path**: The directory inside the repository containing the Kubernetes YAML manifests.

### **4. Choosing the Deployment Target**
- **Destination Kubernetes Cluster**:
  - **Internal Service (`https://kubernetes.default.svc`)** is used because Argo CD runs inside Kubernetes.

### **5. Syncing Applications**
- After creating the application, it will initially be marked **"Out of Sync"**.
- Click **"Sync"** to manually deploy it.
- If **Auto-Sync** is enabled, Argo CD will automatically deploy whenever there’s a change in Git.

---

## **Monitoring and Management in Argo CD**
### **1. Understanding the Sync Process**
- **Argo CD continuously monitors the Git repository**.
- If any difference is detected, the application is marked **"Out of Sync"**.

### **2. Viewing Application Status**
- The **UI provides a visualization of all resources** (Deployments, ReplicaSets, Pods, Services).
- You can track:
  - **Pod creation and scaling**
  - **Deployment health and logs**
  - **Version history of each deployment**

### **3. Rollback and Disaster Recovery**
- Since **Argo CD tracks all changes in Git**, rolling back is simple:
  - **Select a previous commit**.
  - Click **"Sync"** to revert to that state.



## **Benefits of GitOps and Argo CD**
| Feature | DevOps (Jenkins) | GitOps (Argo CD) |
|---------|-----------------|------------------|
| **Source of Truth** | Multiple sources (manual, Jenkins, Git) |  **Single source (Git)** |
| **Manual Changes** | Allowed, can cause inconsistencies |  **Only through Git (PR-based changes)** |
| **Change Tracking** | Hard to track |  **Full version history in Git** |
| **Automation** | Partially automated |  **Fully automated** |
| **Rollback** | Complex and error-prone |  **Easy with Git history** |
| **Security** | Requires credentials, risk of human errors |  **More secure, no direct manual changes** |

 >GitOps (Argo CD) is a more efficient, secure, and scalable approach compared to traditional DevOps methods.

