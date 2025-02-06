# **01 Introduction to DevOps & Git Foundation**

This document outlines the core concepts discussed in the lecture on **DevOps** and **Git**. It covers cultural aspects of DevOps, the twelve-factor application methodology for scalable systems, and foundational Git commands and workflows.

---
## Topics Covered:
1. Cultural Aspects of DevOps  
2. How DevOps Came Into Picture?  
3. Twelve-Factor Application  
4. Foundation of Git  

---

# **Cultural Aspects of DevOps**

### **What is DevOps?**  
DevOps is not a tool or a technology; it is a **practice or methodology** aimed at improving collaboration between **development** and **operations** teams to deliver high-quality software quickly and efficiently. To support this methodology, various tools have been developed.

---

### **Traditional Workflow Challenges**  
In a traditional software development process:  
- Developers work on code in their local machines.  
- The testing team fetches the code and tests it after weeks or months of development.  
- If issues are found, the code is sent back to the development team.  
- This cycle continues, creating **delays** and **inefficiencies**.

The **DevOps approach** addresses these delays by fostering better collaboration and automation between teams, reducing the time to deliver a working product to the end user.

---

### **Key Principles of DevOps**
1. **Automation**  
   - Automate repetitive tasks to reduce manual intervention.  
   - Automation increases consistency and efficiency across deployments.

2. **CI/CD (Continuous Integration/Continuous Delivery)**  
   - **Continuous Integration**: Developers regularly integrate new code into a shared repository, ensuring that all changes are continuously tested.  
   - **Continuous Delivery**: Code changes are automatically prepared for release to production, ensuring that the product is always in a releasable state.

3. **Monitoring and Logging**  
   - Continuous monitoring of applications helps in identifying and resolving issues quickly.  
   - Logging allows developers to track events, analyze performance, and fix bugs efficiently.

**Summary**:  
DevOps aims to build **highly scalable** and **easily maintainable systems**. To achieve this, it incorporates the **Twelve-Factor Methodology** for building cloud-native applications.

---

# **The Twelve-Factor Application**

### **What is the Twelve-Factor Methodology?**  
The Twelve-Factor methodology was introduced by cloud platforms to provide **best practices** for building applications that are **easily deployable** and **scalable** in cloud environments.  

---

### **The Twelve Pillars**  

1. **Codebase**  
   - Maintain a **single codebase** in a **version-controlled system**.  
   - Both development and QA teams should work from the same repository to avoid discrepancies.  
   - Code progresses through different environments: Development → QA → Staging → Production.

2. **Dependencies**  
   - Applications should declare and isolate their dependencies to prevent conflicts.  
   - This ensures that all services and libraries required to run the application are properly managed.

3. **Configuration**  
   - Separate **configuration settings** for different environments (e.g., development, staging, production).  
   - Store configuration details in a way that is easy to manage and secure.

4. **Backing Services**  
   - Applications rely on external services like databases, message queues, and storage.  
   - These services should be easily replaceable without code changes to enhance flexibility.

5. **Build, Release, Run**  
   - **Build**: Compile the source code.  
   - **Release**: Package the build with the configuration for a specific environment.  
   - **Run**: Execute the release in the environment.

6. **Processes**  
   - Run applications as **stateless processes** to enhance scalability.  
   - Stateless processes do not depend on stored data, making them more resilient.

7. **Port Binding**  
   - Applications should self-contain their services by **binding to specific ports**.  
   - This isolation prevents interference with other services.

8. **Concurrency**  
   - Design applications to **scale out** by running multiple instances of processes.

9. **Disposability**  
   - Ensure **fast startup** and **graceful shutdown** to maximize robustness.

10. **Dev/Prod Parity**  
    - Keep **development, staging, and production environments** as similar as possible to avoid deployment issues.

11. **Logs**  
    - Applications should generate **continuous logs** that can be analyzed to detect and troubleshoot problems.

12. **Admin Processes**  
    - Perform administrative tasks like **database migrations** and **backups** through specialized tools or scheduled jobs.

---

# **Git - The Foundation of Version Control**

Git is a **version control system** that records changes in files over time, allowing developers to collaborate efficiently on projects.

---

### **Need for Git**  
Before Git, developers faced challenges when sharing code:  
- Using physical storage like **pendrives** was inefficient.  
- Shared documents like **Google Docs** introduced visibility but lacked proper version control.

Git revolutionized this by providing **distributed version control**, enabling developers to track changes and collaborate efficiently.

---

### **Key Concepts in Git**

| **Concept**    | **Description**                                             |
|----------------|-------------------------------------------------------------|
| **Repository** | A collection of all project files and their version history. |
| **Branch**     | A parallel version of the repository for working on specific features. |
| **Merge**      | Combines changes from multiple branches into a single branch. |
| **Pull**       | Fetches and updates the local repository from a remote repository. |

---

### **Understanding Branches**  
- **Master Branch**: The main branch that represents production-ready code.  
- Developers create **feature branches** from the master branch to work on specific features.  
- After completing work, developers **merge** their changes back into the master branch.

#### **Branching Example**  
- Master branch contains files `F1` and `F2`.  
- Developer A creates a branch and adds file `F_Dev_1`.  
- Developer B creates another branch and adds file `F_Dev_2`.  
- Both branches are merged into the master branch after review.

---

### **Git Workflow Demonstration**  
- **Master Branch**: Live in production.  
- **Branches**:  
  - **Dev**: Development team works here.  
  - **Test**: Testing team works here.  
  - **Stage**: Merges changes before pushing to production.

---

### **Basic Git Commands**

| **Command**              | **Description**                                              |
|--------------------------|--------------------------------------------------------------|
| `git init`                | Initializes a folder as a Git repository.                   |
| `git status`              | Shows the current status of files in the repository.         |
| `git add <file_name>`     | Stages changes to be committed.                              |
| `git rm --cached <file>`  | Removes a file from the staging area.                        |
| `git commit -m "<msg>"`   | Commits the staged changes with a message.                   |
| `git diff <file_name>`    | Shows the differences between the working file and staged file. |
| `git restore <file_name>` | Restores the file to its previous state before staging.       |

---

### **Visual Representation of Git Branching**

#### **Example Tree Structure**  
- **Master Branch**  
  └── **Dev Branch**  
  │   ├── Feature 1  
  │   ├── Feature 2  
  │   └── Feature 3  
  └── **Stage Branch**  
      └── Test Branch  

---

### **Live Demonstration**
**[Message for Instructor]**: Show students a live Git demonstration to reinforce concepts of initializing repositories, branching, merging, and basic Git commands.

---

### **Summary of Git Commands**  
1. `git --help` – View Git command options.  
2. `git init` – Initialize a repository.  
3. `git status` – Check the repository status.  
4. `git add <file_name>` – Stage changes for commit.  
5. `git commit -m "<msg>"` – Commit changes.  
6. `git diff <file_name>` – View differences in files.  
7. `git restore <file_name>` – Restore files before staging.

