
# Types Notes - Class3- Mastering Jenkins Pipelines and Administration  

In this session, we will be covering the following topics related to Jenkins pipeline and administration:  

- **Build Triggers**: Understanding different mechanisms to trigger a Jenkins job.  
- **SCM Polling**: How Jenkins monitors source code repositories for changes.  
- **Webhooks**: A real-time event-driven alternative to SCM Polling.  
- **Parallel Pipeline**: Running independent jobs simultaneously for efficiency.  
- **Multibranch Pipeline**: Managing multiple branches within a single pipeline.  
- **Folders**: Organizing and managing Jenkins jobs effectively.  
- **Notifications in Jenkins**: Setting up alerts and notifications for job completion.  
- **Backup**: Ensuring Jenkins data is secure and recoverable.  

---

## Build Triggers  

### Overview  

- Build triggers are mechanisms in Jenkins that automatically start a job when specific conditions are met.  
- Up until now, jobs have been triggered manually. However, Jenkins provides several ways to automate job execution.  
- The different types of triggers include:  
  1. **Scheduled Triggers**  
  2. **Remote Triggers**  
  3. **SCM Polling**  

### Remote Triggers  

- Remote triggers allow Jenkins jobs to be triggered using external commands or API calls.  
- These triggers are useful when you want an external system to initiate a job without manual intervention.
---

## SCM Polling  

### What is SCM Polling?  

- **SCM Polling (Source Code Management Polling)** is a mechanism that enables Jenkins to check for changes in the repository at regular intervals.  
- Whenever new changes are detected in the repository, Jenkins automatically triggers a build.  
- This ensures that code changes are continuously integrated and tested, helping developers quickly identify and fix issues.  

### Downsides of SCM Polling  

- While SCM Polling ensures frequent code integration, it **periodically** checks for changes, even if no updates have been made.  
- This leads to unnecessary resource consumption, making it an inefficient approach.  
- To optimize this process, **webhooks** provide a more efficient alternative.  

---

## Webhooks  

### What is a Webhook?  

- A **webhook** is a mechanism that enables one system to notify another about events in real time.  
- It allows applications to communicate automatically when specific events occur.  
- Webhooks are commonly used for:  
  - Software development and automation  
  - Integrating different services  
  - Reducing the need for frequent polling  

### How Webhooks Work in Jenkins  

- Instead of Jenkins polling the repository repeatedly, **webhooks push updates automatically** whenever changes occur.  
- When a developer commits code, the webhook sends an event to Jenkins, triggering the pipeline immediately.  

### Steps to Implement Webhooks in Jenkins  

1. **Create a Webhook in Git**  
   - Set up a webhook in your Git repository to send notifications to Jenkins.  
2. **Create a Pipeline in Jenkins**  
   - Configure the pipeline to listen for webhook events.  
3. **Trigger the Pipeline Automatically**  
   - Whenever a new commit is pushed, Git will send a trigger to Jenkins, starting the build process.  

---

## Build After Other Projects Are Built  

### Use Case  

- In certain scenarios, one job's completion should trigger the execution of another job.  
- Consider the case where we have three jobs: **Job1, Job2, and Job3**.  
- The sequence should be:  
  - **Job1 completes → Job2 starts**  
  - **Job2 completes → Job3 starts**  

### How Jenkins Handles This  

- Jenkins provides the "Build after other projects are built" trigger.  
- This feature ensures that dependent jobs execute sequentially without manual intervention.  
- Essentially, this is a **chained execution**, forming a simple pipeline.  

---

## Parallel Pipeline  

### What is a Parallel Pipeline?  

- A **Parallel Pipeline** allows independent tasks to run simultaneously instead of sequentially.  
- This significantly reduces total execution time when dealing with tasks that do not depend on each other.  

### Example Scenario  

- Consider a build pipeline with the following test stages:  
  1. **JUnit Testing** (takes 5 hours)  
  2. **Regression Testing** (takes 7 hours)  

- Running these tests sequentially would take **12 hours** (5 + 7).  
- However, since they are **independent**, they can be executed **in parallel**, reducing the total execution time to **7 hours** (the longest stage).  

### Benefits of Parallel Pipelines  

- **Improved Efficiency**: Tasks complete faster by running simultaneously.  
- **Optimal Resource Utilization**: Jenkins can distribute workloads more effectively.  
- **Better Scalability**: Supports large projects with multiple independent processes.  

---

## Multibranch Pipeline  

### What is a Multibranch Pipeline?  

- A **Multibranch Pipeline** allows Jenkins to automatically detect and create pipelines for **multiple branches** in a Git repository.  
- Instead of creating separate pipelines for each branch, Jenkins manages all branches within a **single pipeline configuration**.  

### How It Works  

1. Jenkins scans the Git repository for **Jenkinsfiles** in different branches.  
2. A separate pipeline is created for each branch containing a **Jenkinsfile**.  
3. Only the branch with new commits is triggered, **ensuring independent workflows**.  

### Benefits  

- **Automatic Branch Discovery**: Detects new branches and removes inactive ones.  
- **Isolated Testing**: Each branch gets its own pipeline execution.  
- **Efficient CI/CD Workflow**: Developers can push changes without affecting others.  

### Example Scenario  

- Suppose we have **4 development branches** (`dev1`, `dev2`, `dev3`, `dev4`).  
- Each developer works on a separate branch, and once the work is complete, the code is merged into the **staging branch**.  
- Jenkins ensures:  
  - When `dev1` pushes changes, **only dev1's pipeline runs**.  
  - The same applies for `dev2`, `dev3`, and `dev4`.  
  - Finally, when the **staging branch** receives a push, a **final integration test** is triggered before merging into `main`.  

![Jenkins multibranch pipeline](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/107/404/original/jenkins_multibranch_pipeline.png?1738990707)  
---

## Folders in Jenkins  

### Why Use Folders?  

- In large-scale Jenkins environments, **thousands of jobs** are often created for various purposes.  
- This leads to **cluttered job management**, making it difficult to locate and manage jobs effectively.  

### How Folders Help  

- Jenkins provides **folders** to organize jobs in a structured way, similar to **namespaces** in programming.  
- Teams can have separate folders, such as:  
  - **Developers** (e.g., feature builds)  
  - **QA Team** (e.g., test pipelines)  
  - **Payments Team** (e.g., payment service jobs)  
  - **Billing Team** (e.g., invoice processing jobs)  

- This improves job organization and enhances the maintainability of Jenkins jobs.  
---

## Notifications in Jenkins  

### Importance of Notifications  

- Once a job completes (successfully or fails), it is important to notify relevant stakeholders.  
- Jenkins provides multiple ways to send notifications:  
  - **Email**: Send automated job status updates via email.  
  - **Slack**: Integrate with Slack channels for real-time alerts.  
  - **ChatOps**: Use collaboration tools like Microsoft Teams or Mattermost for notifications.  

---

## Conclusion  

This session covered essential concepts in Jenkins pipelines and administration, including:  

- Various **build triggers** (manual, scheduled, remote, SCM polling, and webhooks).  
- How **parallel pipelines** enhance efficiency.  
- The advantages of **multibranch pipelines** in managing multiple branches.  
- Organizing Jenkins jobs using **folders**.  
- Setting up **notifications** for job status updates.  

These topics are crucial for mastering Jenkins automation and optimizing CI/CD workflows. 🚀
