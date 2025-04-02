# Efficient Workflows and Security Practices  

## Cache and Dependencies  

### Understanding Caching in CI/CD Workflows  

When building software or installing dependencies, the initial setup can take a significant amount of time. However, subsequent installations tend to be much faster.  

**Question :** Why do dependencies take longer to install initially but run faster in later executions?  
**Answer:** The first installation downloads and sets up all required dependencies, but later runs can **reuse cached dependencies** instead of reinstalling them, thereby saving time. This optimization is achieved through **caching**.  

### What is a Cache?  

A **cache** is a high-speed data storage layer that retains frequently accessed data, making it readily available for future use without needing to fetch it from the original source again.  

### How Caching Works in GitHub Actions/GitLab CI  

Caching in CI/CD workflows works by storing frequently used files in a **shared location** so they can be accessed across multiple workflow runs.  

**Example:**  
1. **First Run:**  
   - Dependency Installation: **10 minutes**  
   - Code Execution: **2 minutes**  
   - **Total Execution Time:** **12 minutes**  
2. **Subsequent Runs:**  
   - Dependency Installation **skipped (cached)**  
   - Code Execution: **2 minutes**  
   - **Total Execution Time:** **2 minutes**  

By caching dependencies, we avoid redundant installations and significantly improve workflow speed.  

### Types of Cache Used in CI/CD  

- **Package Dependency Caching** – Stores package manager dependencies like `node_modules`, `pip`, or `maven` dependencies.  
- **Build Artifacts** – Reuses compiled code, saving time on future builds.  
- **Temporary Files** – Retains logs, reports, and other intermediate files for quick reference.  

### Example: Caching npm Dependencies in GitHub Actions  

Below is an example of caching **node_modules** to avoid unnecessary dependency installations:  

![npm script](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/112/637/original/Screenshot_2025-03-06_071255.png?1741225401)  

- The **cache key** is used to create an identifier for stored dependencies.  
- If no cache is found for the provided key, the workflow falls back to the **default cache**.  

### Identifying Your Cache  

**Question :** How do we identify which cache is being used in our workflow?  
**Answer:** By referencing the **npm static value** assigned during caching.  

### Branch-Based Cache Referencing  

GitHub Actions allow caches to be referenced across branches. The diagram below illustrates how different branches can **reuse cache data**:  

![Cache branches](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/112/639/original/Screenshot_2025-03-06_073317.png?1741226613)  

- **Test B** can reuse cache from **Test A** and the **Main branch**.  
- **Test A** can only reference the **Main branch**.  
- The **Main branch** can only use its own cache.  

---

## Services  

### What Are Services in CI/CD Workflows?  

In CI/CD workflows, services refer to **additional containers** that run alongside the primary container, providing essential dependencies required for job execution.  

### Key Characteristics of Services  

- Services are **started before the primary job**.  
- They remain **active throughout** the job execution.  
- If a **service fails**, the job relying on it will also **fail**.  
- When the **job completes**, the associated **service shuts down automatically**.  

### Example: Using a Database Service in a CI/CD Pipeline  

Consider a case where a test suite requires a **PostgreSQL database**. Instead of installing and configuring PostgreSQL within the job, a **service container** can be used:  

![Service Example](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/112/640/original/Screenshot_2025-03-06_074121.png?1741227090)  


---

## Reusable Workflows  

### Why Use Reusable Workflows?  

**Reusable workflows** allow teams to:  

- **Encapsulate common t
s** for easy reuse across multiple workflows.  
- **Improve maintainability** by centralizing frequently used processes.  
- **Keep repositories clean** and modular.  

### How Do Reusable Workflows Work?  

A **reusable workflow** is a predefined set of jobs that can be **called by other workflows**. However, a reusable workflow **does not execute on its own**; it must be invoked by another workflow.  

### Example: Using a Reusable Workflow  

#### 1. Creating a Reusable Workflow  

![Reusable Workflow](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/112/641/original/Screenshot_2025-03-06_080348.png?1741228437)  

#### 2. Calling the Reusable Workflow  

![Triggering Workflow](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/112/642/original/Screenshot_2025-03-06_080324.png?1741228536)  

- The **calling workflow** specifies **which environment** to use.  

### Understanding Workflow Dispatch  

- **Workflow Dispatch** defines whether the workflow should be **manually triggered** or executed automatically.  

### Real-World Example  

![Reusable Jobs](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/112/643/original/Screenshot_2025-03-06_081328.png?1741229027)  

- Workflows like **Twistloc Scan** and **Block Due Scan** are being **reused** across multiple jobs.  

---

## Workflow Optimizations  

### Techniques for Optimizing Workflows  

Optimizations help reduce execution time and resource consumption. Common techniques include:  

1. **Caching Dependencies** – Avoids redundant package installations.  
2. **Matrix Builds** – Runs jobs in **parallel across multiple environments**.  
3. **Limiting Workflow Runs** – Prevents unnecessary executions by using:  
   - **Path triggers**  
   - **Event filters**  
   - **Action conditions**  
4. **Job Timeouts** – Prevents **stuck jobs** by setting execution limits.  
5. **Self-Hosted Runners** – Uses **custom environments** for better control.  
6. **Using Artifacts** – Saves **intermediate results** for reuse in later jobs.  

### Difference Between Artifacts and Caching  

- **Caching**: Stores large, frequently used dependencies.  
- **Artifacts**: Stores intermediate **build outputs** for reuse.  

---

## Limitations of CI/CD Workflows  

### Key Limitations  

1. **Limited Compute Resources**  
   - GitHub-hosted runners provide **2 CPUs, 7GB RAM**.  
   - Workflow execution is limited to **72 hours**.  

2. **Storage Constraints**  
   - **Maximum artifact storage:** **5GB per repository**.  
   - Artifacts are **deleted after 90 days** unless stored externally.  

3. **Lack of Stateful Workflow Support**  
   - No built-in way to track workflow state across multiple runs.  

4. **Secret Management Limitations**  
   - Lacks **automatic secret rotation** and **expiration management**.  

---
