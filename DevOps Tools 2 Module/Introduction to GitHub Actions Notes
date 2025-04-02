# Introduction to GitHub Actions Notes

## **What is GitHub Actions?**
- **GitHub Actions** is a **developer workflow automation tool** that helps automate software development processes.
- It is **not limited to CI/CD** but also supports automation for various tasks like **code quality checks, documentation generation, and infrastructure management**.
- It functions similarly to other CI/CD tools like **Jenkins** and **GitLab CI/CD**, but with unique features.

## **Capabilities of GitHub Actions**
GitHub Actions enables automation across various aspects of software development, including:
- **CI/CD automation** for testing, building, and deploying applications.
- **Code quality enforcement** using tools like ESLint and Prettier.
- **Automated documentation generation** with tools such as Swagger and JavaDoc.
- **Dependency management** to keep software libraries up-to-date.
- **Infrastructure automation** using tools like Terraform and Ansible.
- **Custom workflows** tailored to specific development needs.

## **GitHub Actions vs Other CI/CD Tools**
- **ArgoCD** is primarily for **Kubernetes deployments**, while GitHub Actions is a **general-purpose automation tool**.
- **GitLab CI/CD** and **GitHub Actions** have similar capabilities.
- **Jenkins** follows the same **CI/CD principles** but differs in its implementation.


# **Core Components of GitHub Actions**

![GitHub Actions Workflow](https://hackmd.io/_uploads/ByCmQQSs1g.png)

## **1. Workflows**
- A **workflow** is a set of automated processes defined in a **YAML** file.
- Workflows are stored in the `.github/workflows/` directory of a repository.
- They specify tasks such as **testing, building, and deployment**.

### **Example Workflow File:**
```yaml
name: CI Workflow
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2
      - name: Build Application
        run: echo "Building application..."

## **2. Events**
- **Events** trigger workflows based on specific conditions.
- Common **event types** include:
  - `push` → Triggered when code is pushed to a repository.
  - `pull_request` → Triggered when a pull request is created or updated.
  - `schedule` → Runs workflows on a defined schedule.

### **Example: Defining an Event in a Workflow**
```yaml
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
```

## **3. Jobs**
- A **job** is a group of **steps** executed sequentially.
- Each job runs in an **isolated environment**.
- Jobs can be configured to run **independently or in a sequence**.

### **Example: Defining Multiple Jobs**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run Tests
        run: echo "Running tests..."
  
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Build Application
        run: echo "Building application..."
```

## **4. Steps**
- Steps are **individual commands** executed inside a job.
- They **run sequentially** and perform tasks like:
  - Running shell commands.
  - Calling pre-built actions.
  - Executing scripts.

### **Example: Defining Steps in a Job**
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Deploying to Kubernetes
        run: kubectl apply -f deployment.yaml
```

## **5. Actions**
- **Actions** are reusable units of functionality within workflows.
- Actions can be:
  - **Pre-built** (available in the GitHub Marketplace).
  - **Custom-defined** (created in a separate repository).

### **Example: Using a Pre-built Action**
```yaml
steps:
  - name: Check out repository
    uses: actions/checkout@v2
```

## **6. Runners**
- **Runners** execute workflows on virtual machines.
- Two types of runners:
  - **GitHub-hosted runners**: Pre-configured environments like `ubuntu-latest` or `windows-latest`.
  - **Self-hosted runners**: Custom machines managed by the user.

### **Example: Using a GitHub-Hosted Runner**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
```

### **Example: Running a Job on a Self-Hosted Runner**
```yaml
jobs:
  custom-runner:
    runs-on: self-hosted
```

## **Introduction to GitHub Actions Workflows**
- A **GitHub repository** has been created containing a **simple JavaScript application**.
- The repository consists of essential files, including:
  - `index.js` → The main JavaScript file.
  - `package.json` → Contains project dependencies and scripts.
- A **workflow** has been defined under the `.github/workflows/` directory.
- The goal of this session is to **understand workflows**, their **structure**, and how they function within GitHub Actions.


## **Cloning the Repository**
- When cloning a repository, **hidden folders** (like `.github/`) are **not visible by default**.
- To check all files, including hidden ones, use:
  ```bash
  ls -a
  
- Inside `.github/workflows/`, the workflow YAML file can be found, defining automation rules.

## **Workflow Structure**
A **GitHub Actions workflow** is defined in a **YAML** file and consists of the following key components:

### **Key Components**
1. **Workflow Name**
   - Defines the **name of the workflow**.
   - Helps in identifying workflows in the **Actions** tab.
  
2. **Triggering Events**
   - Specifies **when** the workflow should be executed.
   - Example:
     ```yaml
     on:
       push:
         branches:
           - main
       pull_request:
         branches:
           - main
     ```
   - The workflow runs when:
     - A commit is pushed to the `main` branch.
     - A **pull request** is opened for the `main` branch.

3. **Jobs**
   - A workflow consists of multiple **jobs**.
   - Each job performs a specific task (e.g., `build`, `test`, `deploy`).
   - Jobs can run **independently** or have **dependencies**.

4. **Machine Specification**
   - Jobs specify the **operating system** they run on.
   - Example:
     ```yaml
     jobs:
       build:
         runs-on: ubuntu-latest
     ```


## **Understanding GitHub Actions**
### **1. Checkouts in Workflows**
- The `actions/checkout@v4.2.2` action **fetches repository content** into the workflow environment.
- **Why use checkout?**
  - It allows access to **repository files** during workflow execution.
  - It is necessary for **running tests** and **building applications**.

### **2. Setting Up Node.js**
- The `setup-node` action installs **Node.js** in the workflow environment.
- Example usage:
  ```yaml
  - name: Setup Node.js
    uses: actions/setup-node@v4.2.2
    with:
      node-version: 20
  ```

### **3. Installing Dependencies**
- Dependencies (listed in `package.json`) are installed using:
  ```yaml
  - name: Install Dependencies
    run: npm install
  ```
- Similar to `pip install -r requirements.txt` in Python.

### **4. Building and Testing the Application**
- **Building the application:**
  ```yaml
  - name: Build Application
    run: npm run build
  ```
- **Running tests:**
  ```yaml
  - name: Run Tests
    run: npm test
  ```

## **Job Dependencies**
### **Defining Dependencies**
- A job can depend on another job using `needs`, ensuring proper execution order.
- Example:
  ```yaml
  jobs:
    test:
      needs: build
  ```
- Here, the **`test` job will only run if `build` is successful**.
- This is similar to the `depends_on` concept in Terraform.


## **Deploy Job and Workflow Execution**
- The **deployment process** should only begin **after build and testing succeed**.
- The `deploy` job should be dependent on `test`:
  ```yaml
  jobs:
    deploy:
      needs: test
  ```
- This ensures that deployment **does not proceed if the tests fail**.

## **Running the Workflow**
### **1. Triggering a Workflow**
- Workflows are triggered based on events:
  - Example: A **commit** to the `main` branch triggers the workflow.
- Commits can be made via:
  - **GitHub UI** → Direct file edits.
  - **Terminal** → Using `git commit` and `git push`.

### **2. Viewing Workflow Execution**
- Go to the **Actions** tab in GitHub.
- Click on the workflow run to:
  - See **logs**.
  - Monitor **job execution**.
  - Identify **errors or failures**.

# **Understanding Runners**
- **Runners** execute jobs in workflows.
- Two types of runners exist:

### **1. GitHub-Hosted Runners**
- Managed by **GitHub**.
- Pre-installed with:
  - **Operating Systems** (`ubuntu-latest`, `windows-latest`).
  - **Development Tools** (Node.js, Python, Docker, etc.).
- Free-tier available.

### **2. Self-Hosted Runners**
- Managed by **the user**.
- **Customizable**:
  - Choose **OS** and **software**.
  - Configure **hardware settings**.
- Requires **manual setup**.

## **Setting Up a Self-Hosted Runner**
### **1. Creating a Self-Hosted Runner**
- Use a **virtual machine (VM)** or **on-premise machine**.
- Go to **GitHub Settings → Actions → Runners**.
- Click **New Self-Hosted Runner**.
- Select an **OS** (Linux, macOS, or Windows).
- GitHub provides a **set of commands** for setup.

### **2. Configuring the Runner on a Machine**
1. **Download the Runner Package**
   ```bash
   curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz
   ```

2. **Extract the Package**
   ```bash
   tar xzf actions-runner-linux-x64.tar.gz
   ```

3. **Configure the Runner**
   ```bash
   ./config.sh --url <repository_url> --token <github_token>
   ```
   - **`--url`** → Connects to the repository.
   - **`--token`** → Authenticates the machine.

4. **Start the Runner**
   ```bash
   ./run.sh
   ```
   - The runner **listens for jobs** from GitHub.

## **Modifying the Workflow to Use a Self-Hosted Runner**
- Update the workflow file:
  ```yaml
  jobs:
    build:
      runs-on: self-hosted
  ```
- Now, the **build job** runs on the **self-hosted machine**.


## **Running Different Jobs on Different Machines**
- Jobs can be distributed across **GitHub-hosted and self-hosted runners**:
  ```yaml
  jobs:
    build:
      runs-on: self-hosted

    test:
      runs-on: ubuntu-latest
      needs: build

    deploy:
      runs-on: ubuntu-latest
      needs: test
  ```
- **Build runs on a self-hosted runner**.
- **Test and Deploy run on GitHub-hosted Ubuntu**.
