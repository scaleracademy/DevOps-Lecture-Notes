# Lecture Notes: Secrets, Events, and Workflow Optimization

In this session, we will discuss key concepts related to workflow optimization, handling secrets, and event-driven triggers in GitHub Actions. The main topics include:  

- **Multi-Job Workflows**: Managing dependent jobs, using matrix strategies, and handling errors.  
- **Events and Triggers**: Understanding different types of events and their use cases.  
- **Parallelism and Concurrency**: Optimizing workflow execution and managing simultaneous job execution.  
- **Secrets and Variables**: Managing sensitive information and environment variables within GitHub Actions.  
- **Handling Multiple Events**: Exploring how to configure workflows to respond to multiple event triggers.  

## **Multi-Job Workflow**  

A **multi-job workflow** enables executing multiple jobs within a workflow, allowing better organization and execution of tasks. There are three major aspects to consider:  

### **Dependent Jobs**  

- Dependent jobs are those that only start after a preceding job has completed.  
- These dependencies are defined using the `needs` keyword in GitHub Actions.  
- Example configuration:  
  ```yaml
  jobs:
    deploy:
      needs: build
      runs-on: ubuntu-latest
      steps:
        - name: Deploy application
          run: echo "Deploying application..."
  ```  

### **Matrix Strategy**  

- When a job needs to be executed with different configurations (e.g., multiple versions of Node.js), using separate jobs for each configuration is inefficient.  
- Instead, we use a **matrix strategy** to define multiple configurations dynamically.  
- Example configuration:  
  ```yaml
  jobs:
    test:
      runs-on: ubuntu-latest
      strategy:
        matrix:
          node-version: [12, 14, 16]
      steps:
        - name: Setup Node.js
          uses: actions/setup-node@v3
          with:
            node-version: ${{ matrix.node-version }}
  ```  


### **Handling Errors in Workflows**  

- GitHub Actions provides a `continue-on-error` option to allow a workflow to proceed even if a particular step fails.  
- Consider the following scenario:  
  - The workflow consists of three jobs: **Build → Test → Deploy**.  
  - The test job takes **4-5 hours** to complete because of multiple test stages.  
  - If the test job fails, debugging it can take an additional **1-2 hours**.  
  - If following **GitOps**, deployment cannot proceed unless all jobs succeed.  
  - However, **ArgoCD** manages deployments and will revert any direct deployment attempt.  
- The **continue-on-error** option helps to handle such cases by allowing the workflow to continue even if a step fails.  
  ```yaml
  jobs:
    test:
      runs-on: ubuntu-latest
      steps:
        - run: npm test
          continue-on-error: true
        - run: echo "Proceeding despite errors"
  ```  

### **Setting Timeouts for Jobs**  

- To prevent jobs from running indefinitely, GitHub Actions allows setting a timeout for each job.  
- Example configuration:  
  ```yaml
  jobs:
    test:
      runs-on: ubuntu-latest
      timeout-minutes: 5
      steps:
        - run: npm test
  ```  



## **Triggers in GitHub Actions**  

GitHub Actions can be triggered by various **events**. Some common triggers include:  

- `issues` – Triggered when an issue is created, modified, or closed.  
- `issue_comment` – Triggered when a comment is added to an issue.  
- `push` – Triggered when code is pushed to a repository.  
- `pull_request` – Triggered on pull request actions like open, close, or merge.  
- `release` – Triggered when a new release is published.  
- `tags` – Triggered when a tag is created or deleted.  

Example configuration:  
```yaml
on:
  push:
    branches:
      - main
  pull_request:
    types: [opened, synchronize, closed]
```  



## **Parallelism and Concurrency**  

### **Parallelism**  

- Parallelism refers to executing multiple jobs simultaneously, speeding up the workflow.  
- Example: Running **Build, Test, and Deploy** jobs in parallel.  
  ```yaml
  jobs:
    build:
      runs-on: ubuntu-latest
    test:
      runs-on: ubuntu-latest
    deploy:
      runs-on: ubuntu-latest
  ```  

### **Concurrency**  

- Concurrency controls the execution of workflows to avoid conflicts when multiple jobs are triggered at the same time.  
- Consider a scenario where:  
  - A workflow is triggered on every commit.  
  - The workflow takes **2 hours** to complete.  
  - If a new commit arrives before completion, we have two choices:  
    1. Wait for the existing pipeline to complete.  
    2. Cancel the ongoing pipeline and start a new one with the latest code.  
- This is handled using **cancel-in-progress** in concurrency settings.  
  ```yaml
  jobs:
    build:
      runs-on: ubuntu-latest
      concurrency:
        group: build-group
        cancel-in-progress: true
  ```  


## **Environment Variables in GitHub Actions**  

Environment variables allow dynamic values to be reused within workflows. They are categorized into:  

### **Custom Environment Variables**  

- Defined at various levels within workflows:  

#### **Workflow Level**  
```yaml
name: Example Workflow
on: push
env:
  DEPLOY_ENV: production
```  

#### **Job Level**  
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    env:
      DEPLOY_ENV: production
```  

#### **Step Level**  
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Set environment variable
        run: echo "DEPLOY_ENV=Production" >> $GITHUB_ENV
```  

#### **UI Level**  
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    env:
      DEPLOY_ENV: ${{ variables.DEPLOY_ENV }}
```  

### **Default Environment Variables**  

These are predefined by GitHub and do not require explicit declaration. Examples include:  

- `GITHUB_WORKSPACE` – The default working directory of the job.  
- `GITHUB_SHA` – The commit SHA of the current workflow execution.  
- `GITHUB_REPOSITORY` – The repository where the workflow is running.  
- `GITHUB_REF` – The branch or tag ref that triggered the workflow.  
- `GITHUB_EVENT_NAME` – The event name that triggered the workflow.  
- `GITHUB_WORKFLOW` – The name of the current workflow.  


## **Secrets in GitHub Actions**  

### **What are Secrets?**  

- Secrets store sensitive information like API tokens, passwords, and keys.  
- GitHub automatically **encrypts** secrets, and they are not logged in workflow outputs.  
- Example usage in a workflow:  
  ```yaml
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - name: Access API Key
          env:
            API_KEY: ${{ secrets.API_KEY }}
  ```  

### **GITHUB_TOKEN**  

- `GITHUB_TOKEN` is an **automatically generated secret token** provided by GitHub for authentication.  
- A unique token is generated for each workflow run.  
- Example usage:  
  ```yaml
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - name: Use GITHUB_TOKEN
          run: echo "Using GitHub Token"
          env:
            GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  ```  

## **Conclusion**  

This session covered essential GitHub Actions concepts such as multi-job workflows, event triggers, parallelism, concurrency, environment variables, and handling secrets securely. Understanding these principles helps in building **efficient, automated, and secure CI/CD pipelines**.
