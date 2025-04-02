## Typed Notes - Class 1 - Introduction to CI/CD & Jenkins

## **CI/CD**  

### **Continuous Integration (CI)**  
- **Definition:**  
  Continuous Integration (CI) is a development practice where developers frequently integrate code into a shared repository.  
  Each integration is automatically verified by automated builds and tests.  

- **Purpose:**  
  - Ensures early detection of integration issues.  
  - Encourages collaboration among team members.  

- **Process:**  
  1. Developers commit code to a version control system (e.g., Git).  
  2. An automated build process compiles the code and runs tests.  
  3. If the build and tests pass, the changes are merged into the main branch.  

- **Benefits:**  
  - Faster feedback on code changes.  
  - Reduces integration challenges during the development cycle.  
  - Improves code quality through automated testing.

---

### **Continuous Deployment (CD)**  
- **Definition:**  
  Continuous Deployment is the practice of automatically deploying code changes to the production environment without manual intervention.  

- **Key Features:**  
  - Ensures faster delivery of new features to users.  
  - Requires robust automated testing to ensure reliability.  

- **Process:**  
  1. Code changes are pushed to a repository.  
  2. CI processes validate the changes through builds and tests.  
  3. If successful, the code is deployed directly to production.  

- **Benefits:**  
  - Accelerates software delivery cycles.  
  - Reduces manual errors during deployment.  
  - Enhances user satisfaction by delivering updates quickly.  

---

### **Continuous Delivery**  
- **Definition:**  
  Continuous Delivery involves automating the delivery process up to the production environment but requires manual approval to deploy the changes.  

- **Process:**  
  1. Automated CI builds and tests code changes.  
  2. Artifacts are prepared and validated for deployment.  
  3. Deployment to production requires manual approval.  

- **Use Case:**  
  - Suitable for organizations that require regulatory checks or approvals before production deployment.  

![image](https://hackmd.io/_uploads/SkH5fIjwke.png)

---

## **Jenkins Architecture**  

### **Overview of Jenkins**  
- **Purpose:**  
  Jenkins is an open-source automation server that facilitates the automation of software development processes such as build, test, and deployment.  

- **Features:**  
  - Automates repetitive tasks in software delivery.  
  - Integrates with tools like Docker, AWS, GitHub, and more.  

- **Core Components:**  
  1. **Jenkins Server:**  
     - The centralized server managing configurations and jobs.  
  2. **Jobs:**  
     - Represents tasks or projects executed by Jenkins.  
  3. **Users:**  
     - Manages user access and permissions.  
  4. **Plugins:**  
     - Extend Jenkins functionality (e.g., Git, Docker plugins).  

---

![image](https://hackmd.io/_uploads/H1UCmUoDkx.png)


### **Jenkins Architecture**  
1. **Server:**  
   - Centralized component responsible for orchestrating jobs and managing configurations.  
2. **Agents:**  
   - Remote executors that offload job execution to improve scalability.  
3. **Plugins:**  
   - Enhance Jenkins’ capabilities by adding features like integration with third-party tools.  

---

### **Jenkins Installation Requirements**  
1. **System Requirements:**  
   - Minimum 1 GB RAM (higher recommended for larger projects).  
   - Minimum 4 GB disk space for Jenkins and build data.  

2. **Dependencies:**  
   - **Java:**  
     - Required to run Jenkins.  
     - Ensure the appropriate version is installed before setup.  

---

### **Jenkins Configuration**  
1. **Plugin Management:**  
   - Install required plugins (e.g., GitHub, Docker, Pipeline).  
   - Use the plugin manager available in the Jenkins UI.  

2. **Credential Management:**  
   - Add secure credentials (e.g., API tokens, SSH keys) in Jenkins.  
   - Use Jenkins’ credential manager for secure storage.  

3. **Pipeline Setup:**  
   - Define workflows using `Jenkinsfile`.  
   - Example stages: `Build → Test → Deploy`.  

4. **Tool Integration:**  
   - **Docker:** Automate containerized builds.  
   - **AWS:** Enable cloud deployment and resource provisioning.  
   - **GitHub:** Automate code fetching using Git repositories.  

---

### **Types of Jenkins Jobs**  
1. **Freestyle Projects:**  
   - Basic projects with manual configuration options.  
   - Suitable for simple automation tasks.  

2. **Pipeline Projects:**  
   - Define the entire build process as code.  
   - Written in a `Jenkinsfile`.  
   - Provides flexibility and version control.  

3. **Multi-Configuration Jobs:**  
   - Useful for testing across multiple environments (e.g., OS, browsers).  

---

### **Pipeline Configuration**  
1. **Pipeline as Code:**  
   - Written in a `Jenkinsfile`.  
   - Stored in the version control repository alongside the codebase.  

2. **Pipeline Stages:**  
   - Example:  
     ```groovy
     pipeline {
         agent any
         stages {
             stage('Build') {
                 steps {
                     echo 'Building the project...'
                 }
             }
             stage('Test') {
                 steps {
                     echo 'Running tests...'
                 }
             }
             stage('Deploy') {
                 steps {
                     echo 'Deploying to production...'
                 }
             }
         }
     }
     ```  

3. **Integration with Tools:**  
   - Docker: Build and deploy containers.  
   - AWS: Cloud deployment and scaling.  
   - GitHub: Source code integration for CI/CD workflows.  

---

### **Tips and Best Practices**  
1. **Use Plugins Wisely:**  
   - Select plugins that enhance productivity and suit project requirements.  

2. **Automate Testing:**  
   - Include unit, integration, and functional tests in CI/CD pipelines.  

3. **Secure Credentials:**  
   - Always use the Jenkins credential manager for storing sensitive information.  

4. **Monitor Resources:**  
   - Regularly check server performance (RAM, CPU, disk space).  

5. **Notifications:**  
   - Configure email or chat notifications for build statuses to keep stakeholders informed.  

---

### **Quick Reference**  
- **Credentials:**  
  - Securely store tokens, keys, and other secrets using the Jenkins credential manager.  
- **Pipeline Syntax:**  
  - Use declarative pipelines (`Jenkinsfile`) for consistency and maintainability.  
- **Scalability:**  
  - Leverage agents for distributed builds.  
- **Notifications:**  
  - Set up notifications to alert about success, failure, or other events.  

---
