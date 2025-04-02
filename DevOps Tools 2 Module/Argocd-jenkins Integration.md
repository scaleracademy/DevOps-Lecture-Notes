# Argocd-jenkins Integration

---
title: Agenda of the lecture
description: Recap of last class and topics and flow of today's class
duration: 1500
card_type: cue_card
---
- Understanding CI/CD is crucial to grasp the complete deployment process.
    - Argo CD is a **Continuous Deployment (CD) tool**.
    - It works in combination with **Continuous Integration (CI)**.

## **End-to-End CI/CD Components**
- Example: **Jenkins Project**
  - Used **React application** as an example.
  - **CI**: Continuously integrating new changes.
  - **CD**: Continuously deploying the application.
  - **Docker Hub**: Used to store Docker images.
  - **Kubernetes**: Used for deployment.

- Previous Process:
  - Jenkins built the application.
  - The image was stored in **Docker Hub**.
  - Manually deployed on **Kubernetes**.

- Need for **Automation & Optimization**:
  - Manual processes need to be replaced with **Argo CD** for automation.
  - Integration of **Jenkins & Argo CD** to automate deployment.

## **Jenkins Deployment on Kubernetes**
- Previously, Jenkins was run on an **EC2 instance**.
- Now, we move **Jenkins inside a Kubernetes cluster**.
  - More efficient resource management.
  - Follows best practices for **scalability and automation**.
  - Aligns with GitOps principles.
- **Why move Jenkins to Kubernetes?**
  - Kubernetes is designed to **manage applications** dynamically.
  - Avoids **wasting resources** on standalone EC2 instances.
  - Easily scale and manage Jenkins like other applications.


## **Flow of the Class**
1. **Theory Explanation** – Understand the architecture and workflow.
2. **Demo on an Existing Machine** – Observe the entire process.
3. **Recreating on a New Machine** – Hands-on implementation.


## **Project Components**
#### **1. Application Repository (`html-app-repo`)**
- Contains:
  - **HTML files** (Simple Web Application).
  - **Jenkinsfile** (Defines CI pipeline).
  - **Dockerfile** (Defines containerization).

#### **2. Kubernetes Deployment Repository (`html-demo-app`)**
- Contains:
  - **Kubernetes manifests** (Deployment, Service, etc.).
  - **Customization files**.
  - **`application.yml`** (Argo CD configuration for deployment).

#### **3. Argo CD Jenkins App (`argo-cd-jenkins-app`)**
- Contains:
  - **Helm Chart for Jenkins** (Used for Jenkins deployment).
  - **`application.yml`** (Argo CD application configuration for Jenkins).

## **Deployment Flow**
1. **Kubernetes Cluster**
   - Hosts **Argo CD** and other applications.
  
2. **Argo CD manages two applications:**
   - **HTML Application**
     - Uses `html-app-repo`.
     - Deployment stored in `html-demo-app`.
   - **Jenkins Application**
     - Managed using `argo-cd-jenkins-app`.
     - Runs inside a Kubernetes namespace.

3. **Jenkins runs inside Kubernetes (instead of EC2)**
   - Ensures resource efficiency.
   - Easily managed and scaled via **Argo CD**.

---
title: Practical Demo
description: DevOps: CI/CD Pipeline with Jenkins, ArgoCD, and Kubernetes 
duration: 4200
card_type: cue_card
---

> We discussed how to set up an automated CI/CD pipeline using **Jenkins**, **ArgoCD**, and **Kubernetes**. The goal is to automate the build, test, and deployment processes to streamline software development and deployment.

## Setting Up the Infrastructure
### What is Running on the System?
- The application is running on a **specific port**.
    - We checked which version of the application is currently deployed.

- Jenkins and ArgoCD services were installed using **Helm Charts**.

| Component       | Responsibility       | Managed By |
|----------------|----------------------|------------|
| **Jenkins**    | Automating Build Process | DevOps Team |
| **ArgoCD**     | Continuous Deployment | DevOps Team |
| **Application Code** | Developing the Application | Developers |
| **Index.html** | Updating Frontend UI | Developers |

- Developers update the **index.html** file and commit changes.
- Jenkins triggers a build process upon code changes.
- The pipeline pushes a new Docker image to Docker Hub.
- ArgoCD syncs the latest version and deploys it.


## CI/CD Workflow
### Steps in the Pipeline
1. **Developer Pushes Code:**
   - A new version (e.g., **v3**) of the application is committed to GitHub.
   - If a **webhook** is set up, Jenkins automatically triggers a build.
   - If no webhook is used, the developer manually triggers a build.

2. **Jenkins Pipeline Execution:**
   - Pulls the latest code from GitHub.
   - Builds a new Docker image.
   - Pushes the Docker image to **Docker Hub**.

3. **ArgoCD Deployment Process:**
   - Detects new changes in the Git repository.
   - Updates **customization.yaml** with the new image tag.
   - Applies Kubernetes manifests to deploy the updated application.

4. **Kubernetes Updates the Running Application:**
   - Creates a new pod for the updated application.
   - Old pods are deleted and replaced with the new version.
   - If using **port forwarding**, re-establish the connection to see updates.


## Setting Up Jenkins
### 1. Installing Jenkins
- Install Jenkins in a **Kubernetes cluster** using Helm.
- Ensure that Jenkins is running properly by checking the pods:
  ```
  kubectl get pods -n jenkins
  ```
- Expose Jenkins service:
  ```
  kubectl port-forward svc/jenkins 8080:8080 -n jenkins
  ```
- Access Jenkins via browser: `http://localhost:8080`
- Retrieve the **Admin Password**:
  ```
  kubectl exec -n jenkins -it $(kubectl get pod -n jenkins -l "app.kubernetes.io/component=jenkins-controller" -o jsonpath="{.items[0].metadata.name}") -- cat /var/jenkins_home/secrets/initialAdminPassword
  ```

### 2. Creating a Pipeline in Jenkins
1. Go to **Jenkins Dashboard** → **New Item** → **Pipeline**.
2. Select **Pipeline Script from SCM**.
3. Provide the **Git Repository URL** containing the `Jenkinsfile`.
4. Add **credentials** for GitHub and Docker Hub authentication.
5. Click **Build Now** to start the pipeline.

---

## Jenkinsfile (Pipeline Configuration)
The **Jenkinsfile** contains the following stages:

```groovy
pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials')
        GIT_CREDENTIALS = credentials('github-credentials')
        IMAGE_NAME = "dockerhub_username/html-app"
        IMAGE_VERSION = "${params.VERSION}"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/yourrepo/html-app.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_VERSION .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh 'echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin'
                sh 'docker push $IMAGE_NAME:$IMAGE_VERSION'
            }
        }
        stage('Update Git Repository for ArgoCD') {
            steps {
                sh '''
                git config --global user.email "jenkins@example.com"
                git config --global user.name "Jenkins"
                git clone https://github.com/yourrepo/argocd-repo.git
                cd argocd-repo
                sed -i "s|image: .*|image: $IMAGE_NAME:$IMAGE_VERSION|" kustomization.yaml
                git add .
                git commit -m "Updated image to version $IMAGE_VERSION"
                git push origin main
                '''
            }
        }
    }
}
```

## Deploying with ArgoCD
### 1. Installing ArgoCD
- Install ArgoCD in Kubernetes:
  ```
  kubectl create namespace argocd
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
  ```
- Port-forward to access UI:
  ```
  kubectl port-forward svc/argocd-server -n argocd 8080:443
  ```
- Login with `admin` and retrieve the password:
  ```
  kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
  ```

### 2. Creating an ArgoCD Application
- Apply the ArgoCD application manifest:
  ```yaml
  apiVersion: argoproj.io/v1alpha1
  kind: Application
  metadata:
    name: html-app
    namespace: argocd
  spec:
    project: default
    source:
      repoURL: 'https://github.com/yourrepo/argocd-repo.git'
      path: 'html-app'
      targetRevision: main
    destination:
      server: 'https://kubernetes.default.svc'
      namespace: html-app
    syncPolicy:
      automated:
        selfHeal: true
        prune: true
  ```
- Apply the configuration:
  ```
  kubectl apply -f html-app-application.yaml -n argocd
  ```

---

## Verifying the Deployment
- Check if the application is **running**:
  ```
  kubectl get pods -n html-app
  ```
- Forward the port and access the application:
  ```
  kubectl port-forward svc/html-app 8081:80 -n html-app
  ```
- Open `http://localhost:8081` in a browser.

---
title: RBAC
description: Role-Based Access Control in ArgoCD
duration: 360
card_type: cue_card
---
## What is RBAC?
- RBAC stands for **Role-Based Access Control**.
- It defines **who (user or group)** can perform **what actions** on **which resources**.
- In ArgoCD, RBAC is managed using **ConfigMaps**.
- Any changes to RBAC policies must be updated in the ConfigMaps.

---

## RBAC Policy Format
RBAC policies follow a specific format:

```plaintext
P, <role/user/group>, <resource>, <action>, <object>, <effect>
```

| Field        | Description |
|-------------|-------------|
| **P**       | Policy identifier (defines a policy) |
| **G**       | Group identifier (defines a group) |
| **Role/User** | Specifies the role (e.g., admin) or user/group |
| **Resource** | The resource (e.g., applications, projects, etc.) |
| **Action**   | What actions can be performed (e.g., get, create, delete) |
| **Object**   | Specific object in the resource |
| **Effect**   | Allow or Deny |

- **Example:**
    ```plaintext
    P, role:admin, applications, *, *, allow
    ```
    - This means the **admin role** has **full permissions** (`*`) on **applications**.
    - If written as:
    ```plaintext
    P, role:admin, applications, get, *, allow
    ```
    - The admin role can **only fetch** (`get`) applications but not modify them.

## Creating Users in ArgoCD
- Users are also managed via **ConfigMaps**.
- To create a new user, update the `ConfigMap` in ArgoCD.
- Example:
  ```yaml
  data:
    accounts.<new_user>: "apiKey, login"
  ```
  - This line adds a new user.
  - **apiKey**: Allows API access.
  - **login**: Allows UI login.

## Setting User Passwords
- Passwords are stored in **ArgoCD secrets**.
- The password needs to be **Base64 encoded** before being stored.
- Example command to generate a Base64 password:
  ```bash
  echo -n "mypassword" | base64
  ```
- Update the ArgoCD secret:
  ```yaml
  data:
    admin.password: <Base64-Encoded-Password>
  ```
- Replace `admin.password` with the specific user's password key.

