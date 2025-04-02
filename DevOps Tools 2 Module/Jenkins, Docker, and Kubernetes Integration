# Typed Notes- Class -5 : End-to-End CI/CD Pipeline: Jenkins, Docker, and Kubernetes Integration

---
title: Agenda of the lecture
description: Recap of last class and topics to be discussed in today's class
duration: 240
card_type: cue_card
---
- Recap: 
    - End to End CICD
    - Jobs
    - Credentials
    - Server
    - Plugins
    - Webhooks
    - Trigger
    - Dockers
    - K8ymd file

- Today's class
    - Jenkins Project
    
---
title: Jenkins - The Integration Point
description: Understanding Jenkins as a CI/CD integration tool
duration: 240
card_type: cue_card
---

## **Introduction to Jenkins**
- Jenkins serves as the **integration point** for CI/CD pipelines.
- It automates code integration, builds, and deployment processes.

## **Code and Deployment Scenarios**
- Developers write code and push it to **GitHub**.
- This code may:
  - Be **containerized** (Docker).
  - Be **non-containerized** (traditional monolithic deployment).
- Deployment can happen:
  - **On a server** (direct deployment).
  - **Within a container** (Docker).
  - **In Kubernetes clusters** (EKS, GKE, OpenShift, etc.).
  - **In a Docker Swarm cluster**.

## **Does Jenkins Care About Deployment Type?**
- Jenkins does **not** care about:
  - Whether the application is **monolithic** or **containerized**.
  - Whether deployment is on **Kubernetes, Docker Swarm, or a single machine**.
- Jenkins can handle **any deployment type** with appropriate:
  - **Plugins**.
  - **Pipeline configurations**.


---
title: Jenkins Workflow for Today's Class
description: Understanding Jenkins job execution
duration: 500
card_type: cue_card
---

## **Project Overview**
- The project involves deploying a **React application** hosted on **GitHub**.
- The **goal**: Automate the CI/CD pipeline using Jenkins.

## **Methods to Implement This in Jenkins**
### **1. Using Freestyle Jobs**
- Can be divided into **three individual jobs**:
  - **Job 1**: Checkout code.
  - **Job 2**: Build application.
  - **Job 3**: Deploy application.
- These jobs can be **triggered sequentially**:

### **2. Using a Declarative Pipeline**
- A **single Jenkinsfile** can handle:
  - **Code checkout** from GitHub.
  - **Building a Docker image**.
  - **Pushing the image to Docker Hub**.
  - **Deploying the application on EKS (Amazon Elastic Kubernetes Service)**.

## **Pipeline Stages**
1. **Stage 1: Code Checkout**
   - Jenkins retrieves the code from **GitHub**.

2. **Stage 2: Build Process**
   - Uses the **Dockerfile** to build a **Docker image**.

3. **Stage 3: Push to Docker Hub**
   - Log in to **Docker Hub**.
   - Push the newly created **Docker image** to the repository.

4. **Stage 4: Deployment**
   - Deploy the application to **EKS**.

---
title: Configuring Jenkins for AWS and Docker
description: Setting up Jenkins with AWS and Docker credentials
duration: 2100
card_type: cue_card
---

## **Connecting Jenkins to AWS EKS**

- **Prerequisites for AWS EKS Connectivity**
    - AWS CLI must be installed.
    - AWS credentials (Access Key & Secret Key) must be configured.
    - Kubectl should be installed and configured.

1. **Use AWS CLI to authenticate with EKS**.
2. **Update kubectl configuration** with EKS cluster details.

```
aws eks --region <region-name> update-kubeconfig --name <cluster-name>
```
- This command updates the `kubectl` configuration file to connect with the EKS cluster.



### **AWS CLI Installation**
```sh
sudo apt update
sudo apt install awscli -y
aws --version  # Verify installation
```

### **AWS Configuration Setup**
```sh
aws configure
```
- This prompts for:
  - **Access Key ID**
  - **Secret Key**
  - **Default region name** (e.g., `us-east-1`)
  - **Output format** (default: `json`)


- AWS Configuration for Jenkins
    - **Option 1:** Configure AWS credentials **inside Jenkins**.
    - **Option 2:** Configure AWS credentials **at the system level** (for all users).
    - In this class:
      - **Docker credentials** will be stored in **Jenkins**.
      - **AWS credentials** will be stored **on the server**.

## **Switching to Jenkins User**
```sh
sudo su jenkins
aws configure  # Run the same AWS config setup for Jenkins user
```
- This ensures Jenkins can access AWS services.



- **Plugins Needed for the Pipeline**
    - Docker Plugin
        - Docker API Plugin
    - Kubernetes Plugin
      - Kubernetes API Plugin
      - Kubernetes CLI Plugin
      - Kubernetes Credentials Plugin


- Explore the GitHub Repository and understand the project code:
  - **Source code** (e.g., `app.js` in the `src/` folder).
  - **Public assets**.
  - **Configuration files** (`Dockerfile`, `Jenkinsfile`, `.gitignore`).
  - **Deployment files** (`deployment.yaml`, `service.yaml`).


## **Analyzing the Files**

- **Dockerfile Breakdown**
    1. **Base Image**: Uses **Alpine Linux** as the base image.
    2. **Working Directory**: Sets the working directory to `/react-app`.
    3. **Copy Dependencies**:
       - Copies `package.json` and `package-lock.json` to the container.
    4. **Install Dependencies**:
       - Runs `npm install` to install dependencies.
    5. **Copy Application Files**:
       - Copies **all files** from the host machine to the container.
    6. **Expose Port 3000**:
       - Allows external access to the React app.
    7. **Start Application**:
       - Uses `CMD ["npm", "start"]` to launch the app.

- **Optimization**: Using `.dockerignore`:
     - Prevents unnecessary files from being copied (e.g., `deployment.yaml`, `service.yaml`).
     - Reduces image size.
     - Improves build efficiency.


- **Understanding Deployment.yaml**
    - Creates a **Deployment** in Kubernetes.
    - Defines:
      - **Replicas**: `2` (creates two instances of the app).
      - **Container Image**: **Needs to be built first!**
      - **Ports**: Exposes the application on a defined port.

- **Understanding Service.yaml**
    - Creates a **Load Balancer Service**.
    - Routes traffic to the application based on labels.


---
title: Jenkins Pipeline
description: Pipeline stages and Using webhooks for automation
duration: 3600
card_type: cue_card
---

# **Jenkins Pipeline Stages**
### **Stage 1: Checkout Code**
- Fetches the latest code from GitHub.
- Uses `checkout` command in the pipeline.

```groovy
stage('Checkout') {
    steps {
        git url: 'https://github.com/your-repo.git', branch: 'main'
    }
}
```

### **Stage 2: Build Docker Image**
- Uses `docker build -t` to create the image.
- Image name follows the format: `<username>/<repo>:tag`.

```groovy
stage('Build') {
    steps {
        sh 'docker build -t username/repository:latest .'
    }
}
```

### **Stage 3: Docker Login**
- **Why?** To push the image to **Docker Hub**.
- Credentials are **stored securely in Jenkins**.
- Uses `docker login` command.

```groovy
stage('Docker Login') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
            sh 'echo $PASS | docker login -u $USER --password-stdin'
        }
    }
}
```

### **Stage 4: Push to Docker Hub**
- After login, **push the built image** to Docker Hub.

```groovy
stage('Push Image') {
    steps {
        sh 'docker push username/repository:latest'
    }
}
```

### **Stage 5: Deploy to Kubernetes**
- Uses `kubectl apply -f` to deploy the **Kubernetes YAML files**.
- **Ensures** that the correct Kubernetes context is used.

```groovy
stage('Deploy to EKS') {
    steps {
        sh 'kubectl config use-context my-eks-cluster'
        sh 'kubectl apply -f deployment.yaml'
        sh 'kubectl apply -f service.yaml'
    }
}
```

## **Understanding Jenkins Credentials**
- Jenkins stores **Docker Hub credentials** securely.
- Steps to **create credentials in Jenkins**:
  1. Navigate to **Manage Jenkins → Manage Credentials**.
  2. Select **Global Credentials**.
  3. Click **Add Credentials**.
  4. Choose **Username and Password**.
  5. Enter:
     - **ID**: `docker-credentials`
     - **Username**: Docker Hub username.
     - **Password**: Docker Hub access token.

- **Deploying the Pipeline**
    - **Manual Deployment**: Click "Build Now" in Jenkins.
    - **Automated Deployment**: Use **Webhooks** to trigger builds automatically.


## **Running the Jenkins Pipeline**

### **Steps in the Jenkins Pipeline**
1. **Checkout the repository:** Retrieves the latest code.
2. **Build the Docker image:**
   ```bash
   docker build -t myrepo/myimage .
   ```
3. **Login to Docker Hub:**
   ```bash
   docker login -u <username> -p <token>
   ```
4. **Push to Docker Hub:**
   ```bash
   docker push myrepo/myimage
   ```
5. **Deploy to Kubernetes:**
   ```bash
   kubectl apply -f deployment.yml
   kubectl apply -f service.yml
   ```

## Kubernetes Deployment

- Deployment Configuration (`deployment.yml`)**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: react-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: react-app
  template:
    metadata:
      labels:
        app: react-app
    spec:
      containers:
      - name: react-app
        image: myrepo/myimage:latest
        ports:
        - containerPort: 80
```

- **Verifying Kubernetes Deployment**
    - **Check Running Pods:**
      ```bash
      k get pods
      ```
    - **Check Services:**
      ```bash
      k get svc
      ```
    - **Access the Application:**
      - Retrieve the external load balancer IP and open it in a browser.


## Automating Pipeline Execution with Webhooks

- Why Use Webhooks?
    - Automates the pipeline execution on every code push.
    - Eliminates the need for manual build triggers.

- Configuring Webhooks in Jenkins
    1. Enable **GitHub Webhook Trigger** in the Jenkins job settings.
    2. Obtain the **Jenkins webhook URL**.

- Adding Webhooks in GitHub
    1. Navigate to **GitHub Repository → Settings → Webhooks**.
    2. Click **Add Webhook**.
    3. Enter the Jenkins webhook URL.
    4. Select **Trigger on push events**.
    5. Save and test the webhook.

- Testing Webhook Execution
    - Make a change in the repository:
      ```bash
      git commit -am "Updated deployment file"
      git push origin main
      ```
    - The Jenkins pipeline should start automatically.


## Kubernetes Service Types: NodePort vs LoadBalancer

- NodePort Service
    - Exposes a service on a specific node and port.
    - Requires accessing the service using `nodeIP:port`.
    - Example:
      ```yaml
      type: NodePort
      nodePort: 30080
      ```

- LoadBalancer Service**
    - Automatically assigns an external IP.
    - Ideal for public-facing applications.
    - Example:
      ```yaml
      type: LoadBalancer
      ```

- Checking Kubernetes Cluster
    - **View Nodes:**
      ```bash
      kubectl get nodes
      ```
    - **View Pods:**
      ```bash
      kubectl get pods -o wide
      ```
    - **View Load Balancer Service:**
      ```bash
      kubectl get svc
      ```
