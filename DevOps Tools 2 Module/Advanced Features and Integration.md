# Typed Notes - Class-8 - Advanced Features and Integration

---
title: Agenda of the lecture
description: Topics to be discussed in today's class
duration: 180
card_type: cue_card
---
### **Agenda of the Lecture**
- Understanding the drawbacks of existing application deployment methods.
- **App of Apps** to mitigate issues.
- **Application Sets**.
- **Argo CD** usage and its importance.
- Deployment hooks and **sync waves**.
- **RBAC (Role-Based Access Control)**.

---
title: Fundamentals of Application Management in Kubernetes
description: Why there was a need of App of Apps?
duration: 1400
card_type: cue_card
---
### **Basic Structure of Applications in Argo CD**
- Argo CD provides a GUI to manage applications.
  - ![image](https://hackmd.io/_uploads/HkZMLG19ye.png)

#### **Behavior of Deployments & Pods**
- If **Pod 2** is deleted:
  - It will automatically come back.
  - This happens because the application manages it.
  - The application ensures that the **desired state** (having a certain number of pods) is maintained.
- If a **Deployment** is deleted:
  - It will also come back, since the application manages it.
- If an **Application** itself is deleted:
  - It **will not come back** because nothing is managing it.
  - The entire application and its downstream resources will be lost.

## **The Need for "App of Apps"**
### **Problem: Risk of Deleting the Application**
- A user can accidentally delete an **application**, which deletes:
  - The application itself.
  - Its associated deployments, pods, services, etc.
- There is **no mechanism** to restore the application automatically.

### **Solution: App of Apps**
- Introduces **a parent application** that manages multiple child applications.
- If an application is deleted, the parent application ensures it **is recreated**.
- **Analogy**: 
  - A chef follows a recipe to cook a dish.
  - If the dish is thrown away, it won’t come back.
  - If a **head chef** manages all chefs, they can ensure a dish gets cooked again.

---
title: App of Apps
description: Comparision of Self-Managed Argo CD and App of Apps
duration: 1000
card_type: cue_card
---
### **Example: Amazon Microservices**
- Suppose Amazon has **four microservices**:
  1. **Payment Gateway**
  2. **Order Page**
  3. **Cart Page**
  4. **Customer Wishlist**
- Each microservice is a **separate application**.
- To manage them efficiently:
  - Use **App of Apps** with a **parent application** named `Amazon`.
  - The `Amazon` parent app manages the 4 microservices.
  - If an app is deleted, the parent app restores it.


## **How "App of Apps" Works in Argo CD**
### **Application Structure in Argo CD**
- **Parent Application**:
  - Defines other applications within it.
  - Looks at a repository for application configurations.
- **Child Applications**:
  - Each application is defined separately.
  - Each has its own **namespace, services, deployments**.

#### **Directory Structure Example**
```
repo: argo-cd-apps
│── parent-application.yml  (Defines parent app)
│── app1-directory/
│   ├── application1.yml  (Defines app1)
│── app2-directory/
│   ├── application2.yml  (Defines app2)
```
- ![image](https://hackmd.io/_uploads/BJrK48J9kx.png)
- The **parent application** points to `repo: argo-cd-apps`.
- `App1` and `App2` point to **their respective directories**.

## **Argo CD: Deployment Process**
1. **Cloning Repository**
   - Pull application manifests from the Git repository.
2. **Applying Application Configurations**
   - Use `kubectl apply -f` to deploy apps.
3. **Automatic Synchronization**
   - Argo CD watches the Git repository and applies changes.

### **Demo Process**
- `kubectl apply -f parent-application.yml`
- **Expected Output**:
  - Parent application appears in Argo CD.
  - Child applications automatically get created.

#### **Deleting an Application in App of Apps**
- Deleting a child application results in **immediate recreation** by the parent.
- Deleting the **parent application** removes all child applications.

### **Comparison: Self-Managed Argo CD vs. App of Apps**
| Feature | Self-Managed Argo CD | App of Apps |
|---------|---------------------|------------|
| Purpose | Ensures Argo CD itself is always available. | Ensures applications are never deleted accidentally. |
| How It Works | Argo CD **manages itself** using an application. | A **parent application** manages multiple child applications. |
| Example | If Argo CD is deleted, it **recreates itself**. | If an application is deleted, the **parent application recreates it**. |

---
title: Application Set in Argo CD
description: Understanding Application Set through Demo
duration: 1200
card_type: cue_card
---

## App of Apps: Grouping Applications Together
- **App of Apps is a way to group applications together.**
- Two main use cases:
  1. **Prevent accidental deletion** – If an application is deleted, the parent application recreates it.
  2. **Logical grouping of applications** – Helps manage different types of applications like frontend, backend, and databases.

### **Real-World Use Case: Amazon Services**
- Consider an **Amazon-like** system with:
  - **Frontend services** (UI, web pages).
  - **Backend services** (APIs, processing).
  - **Databases** (Storage systems).
- **Grouping them into a Parent App**:
  - Helps identify all **frontend**, **backend**, and **DB applications** easily.
  - Provides **better visibility and control**.

### **How App of Apps Works**
- **Parent Application** is created.
    - **Child Applications** are created inside the parent.
- **Parent app does not modify child applications**, only manages them.
    - If an application is deleted, the parent restores it.

## Application Set: Automating Application Creation
### **Why Application Set?**
- **Problem with App of Apps**:
  - Requires **manual creation** of each application.
  - If there are **100 applications**, **100 directories** must be created.
  - Hard-coded structure makes it **difficult to scale**.
- **Solution: Application Set**
  - Instead of creating applications manually, **define a template**.
  - **Applications are created dynamically based on parameters**.

## **Understanding Application Set**
- **Similar to using variables in Shell Scripting.**
- Instead of hardcoding, **use templates to generate applications dynamically.**
- Example:  
  - **Shell Script without variables** (Static)
    ```bash
    echo "User: ubuntu"
    echo "User: docker"
    ```
  - **Shell Script with variables** (Dynamic)
    ```bash
    echo "User: $USER"
    ```

### **How Application Set Works**
1. **Define a Template**
   - Specify the structure of the applications.
   - Example: Use `{env}` for different environments (dev, staging, production).
2. **Define the Generator**
   - Specifies **what directories to use**.
   - Example: Create applications for **dev, staging, and production** only.
3. **Applications Are Created Automatically**
   - Unlike App of Apps, **no need to create directories manually**.

### **Application Set Directory Structure**
```
repo: argo-cd-applications
│── application-set.yml  (Defines Application Set)
│── dev/                 (Directory for Dev environment)
│── staging/             (Directory for Staging)
│── production/          (Directory for Production)
```
- **Application Set dynamically creates apps for each environment.**
- **No need to create separate application YAMLs manually.**

## Application Set Demo Walkthrough
### **Application Set YAML Breakdown**
```yaml
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: guestbook-appset
spec:
  generators:
    - list:
        elements:
          - env: dev
          - env: staging
          - env: production
  template:
    metadata:
      name: "{{env}}-guestbook"
    spec:
      destination:
        namespace: "{{env}}"
      source:
        path: guestbook
```
1. **Generators Section**
   - Specifies which environments to create (`dev, staging, production`).
   - Application Set automatically creates apps for these environments.
2. **Template Section**
   - Defines **application structure dynamically**.
   - Uses `{{env}}` as a **placeholder for environment names**.
   - **Example Output:**
     - `dev-guestbook`
     - `staging-guestbook`
     - `production-guestbook`
3. **Destination Namespace**
   - Apps are deployed in separate **namespaces**:
     - `dev` → `dev-guestbook`
     - `staging` → `staging-guestbook`
     - `production` → `production-guestbook`

## Running the Application Set Demo
### **Steps:**
1. **Clone the Repository**
   ```bash
   git clone https://github.com/example/argo-cd-applications.git
   ```
2. **Apply the Application Set YAML**
   ```bash
   kubectl apply -f application-set.yml
   ```
3. **Expected Output:**
   - Argo CD will create:
     - `dev-guestbook`
     - `staging-guestbook`
     - `production-guestbook`
   - **No manual application creation was needed.**
4. **Verify in Argo CD**
   ```bash
   argocd app list
   ```
   - Shows all dynamically created applications.

---
title: Hook and Sync Waves
description: Understanding Hook and Sync Waves in Argo CD with practical demo
duration: 1500
card_type: cue_card
---

## Hooks
- Hooks are **special manifest files** that allow you to perform **custom actions** at different stages of deployment.
- They are used to **control pre-sync, post-sync, and failure actions** in an Argo CD application deployment.

### Types of Hooks:

### 1. PreSync Hook
- Runs **before** an application is synced.
- Example Use Case:
  - **Database migration**: Ensure DB migrations complete before deploying the application.
  - **Service dependencies**: Ensure a required service is running before application sync.
- **Analogy**: Similar to Kubernetes **init containers**, which run pre-tasks before the main container starts.

### 2. PostSync Hook
- Runs **after** the application has been successfully synced.
- Example Use Case:
  - **Trigger a verification job** to check if the deployment was successful.
  - **Send notifications** after successful deployment.

### 3. SyncFail Hook
- Runs **only when** a sync failure occurs.
- Example Use Case:
  - **Send an alert (email, Slack, etc.)** when a sync fails.
  - **Rollback to the previous stable version** if sync fails.
- Hooks are implemented using **annotations** in Kubernetes manifests.

#### **Example: PreSync Hook**
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration-job
  annotations:
    argocd.argoproj.io/hook: PreSync
spec:
  template:
    spec:
      containers:
        - name: migrate
          image: my-database-migration:latest
          command: ["/bin/sh", "-c", "sleep 20 && echo 'Migration Complete'"]
      restartPolicy: Never
```
- **This job runs before the application syncs**.
- It **sleeps for 20 seconds** (simulating a DB migration).

#### **Example: SyncFail Hook**
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: notify-on-failure
  annotations:
    argocd.argoproj.io/hook: SyncFail
spec:
  template:
    spec:
      containers:
        - name: notify
          image: my-notifier:latest
          command: ["/bin/sh", "-c", "echo 'Deployment failed! Sending alert...'"]
      restartPolicy: Never
```
- Runs **only if** sync fails.
- Sends an **alert** notifying that deployment failed.

### **Why Hooks are Important?**
- **Ensures preconditions are met** before syncing an application.
- **Avoids deployment failures** by running critical pre-sync checks.
- **Automates post-deployment actions** like notifications or cleanup tasks.

## Sync Waves in Argo CD

- **Sync waves control the order in which resources are deployed within an application.**
- Used when there are **dependencies** between resources.
- **Resources with a lower sync wave value are deployed first**.

### **Example: Why Sync Order Matters?**
- Consider an application with:
    1. **ConfigMap**
    2. **Deployment**
    3. **Service**
- The **Deployment** **needs** the ConfigMap.
    - If the **Deployment starts before the ConfigMap**, it will fail.
    - **Solution:** Use sync waves.

- Sync waves are set using **annotations**.

#### **Example: Setting Sync Wave Values**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
  annotations:
    argocd.argoproj.io/sync-wave: "0"
data:
  config: "my-config-data"
  
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  template:
    spec:
      containers:
        - name: my-app
          image: my-app:latest

apiVersion: v1
kind: Service
metadata:
  name: my-service
  annotations:
    argocd.argoproj.io/sync-wave: "2"
spec:
  selector:
    app: my-app
```
- **Sync Wave 0** → ConfigMap is deployed first.
- **Sync Wave 1** → Deployment starts after ConfigMap is ready.
- **Sync Wave 2** → Service is created after deployment is ready.

## Why Sync Waves are Important in GitOps?
- **Kubernetes handles some dependencies automatically** (e.g., namespaces, PVCs).
- However, **GitOps tools like Argo CD deploy everything at once** unless controlled.
- **Examples where Sync Waves help:**
  - **Database before Application**: Ensure DB is deployed before backend starts.
  - **Secrets before Deployment**: Ensure secrets exist before an application references them.
  - **Frontend after Backend**: Avoid frontend being deployed before backend is ready.

### **Use Case Example: Multi-Tier Applications**
- Suppose we deploy an **App of Apps** with:
    1. **Database**
    2. **Backend**
    3. **Frontend**
- If **Backend is deployed before the Database**, it will fail.
- Using Sync Waves, the **Database is deployed first**, then the **Backend**, and finally the **Frontend**.

## Demo Walkthrough

#### **Step 1: Modify Application Set**
- Update the parent application to **point to a branch with hooks and sync waves**.

#### **Step 2: Apply the Configuration**
```bash
kubectl apply -f parent-application.yml
```
- **Expected Behavior:**
  - PreSync Hook (DB migration) runs **before** deployment starts.
  - Sync waves control **deployment order**.

#### **Step 3: Verify in Argo CD**
```bash
argocd app get my-app
```
- Shows **syncing status**.
- Confirms if **sync wave order is followed**.
