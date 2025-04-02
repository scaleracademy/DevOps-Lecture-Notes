## Typed Notes - Class-2 Advance Jenkins Concepts

---

### 1. **Pipelines**

#### **Overview**
- **Definition**: Pipelines represent a sequence of automated processes for building, testing, and deploying applications in continuous integration and deployment (CI/CD) systems. They ensure the smooth progression of code changes from development to production.
- **Importance**:
  - Facilitates automation to reduce manual effort.
  - Enhances efficiency and consistency in software delivery.
  - Streamlines error detection and resolution early in the development cycle.

---

#### **Types of Pipelines**

##### **1. Scripted Pipelines**
- **Definition**: A flexible pipeline style written in Groovy with a programmatic approach.
- **Key Characteristics**:
  - Offers granular control over the pipeline logic.
  - Tasks and execution flow are explicitly defined by the developer.
  - Provides access to advanced Groovy functionalities for custom behavior.
- **Advantages**:
  - Highly customizable for unique and complex workflows.
  - Can accommodate non-standard CI/CD requirements.
- **Challenges**:
  - Steep learning curve for those unfamiliar with Groovy or programming.
  - Higher potential for errors due to manual coding.
  - Requires careful debugging and maintenance.

##### **2. Declarative Pipelines**
- **Definition**: A pipeline style using structured, predefined syntax for simplicity and ease of use.
- **Key Characteristics**:
  - Simplifies pipeline creation with a predefined structure.
  - Automatically validates the pipeline syntax before execution.
  - Encourages standardization across teams.
- **Advantages**:
  - Easier to understand, even for beginners.
  - Faster to implement due to its straightforward syntax.
  - Reduces human error with automated validation.
- **Limitations**:
  - Less flexibility compared to scripted pipelines.
  - May not be suitable for highly customized or complex workflows.

---

#### **Pipeline Features**

1. **Parallel Execution**:
   - Allows multiple pipeline stages to run concurrently.
   - Benefits:
     - Optimizes resource utilization.
     - Reduces overall pipeline execution time by processing independent tasks simultaneously.

2. **Stages in a Pipeline**:
   - Logical sections where specific tasks or processes are executed.
   - Common Stages:
     - **Checkout**: Retrieves source code from version control systems (e.g., Git).
     - **Build**: Compiles the source code into deployable artifacts like binaries.
     - **Unit Test**: Validates the correctness of individual software modules.
     - **Regression Test**: Ensures new code changes do not disrupt existing functionality.
     - **Preprod Deployment**: Deploys the application to a pre-production environment for final validation.

---

#### **Pipeline Architecture**

1. **Master-Slave Architecture**:
   - Jenkins employs a distributed architecture for scalability and performance.
   - Components:
     - **Master**:
       - Central server that orchestrates pipeline execution.
       - Delegates tasks to slave nodes based on pipeline requirements.
     - **Slave**:
       - Remote nodes responsible for executing tasks such as building, testing, and deployment.
       - Must have **Java** installed to communicate with the master.

2. **Labels in Pipelines**:
   - **Agent Labels**:
     - Tags that categorize agents (slaves) based on their roles or capabilities (e.g., "Linux agent," "Windows agent").
   - **Node Labels**:
     - Identifiers used to specify where particular tasks should be executed.

---

#### **Pipeline Examples**

1. **Single Server Pipeline**:
   - All tasks (checkout, build, test, deploy) are executed on a single server.
   - **Use Case**:
     - Ideal for small-scale projects with limited resource requirements.
   - **Advantages**:
     - Simplicity in configuration and management.
   - **Limitations**:
     - Limited scalability.
     - Can become a bottleneck for resource-intensive workflows.

2. **Multi-Node Pipeline**:
   - Tasks are distributed across multiple nodes for better scalability and efficiency.
   - **Example Workflow**:
     - **Node 1**: Performs initial stages like code checkout and build.
     - **Node 2**: Handles testing tasks, including unit and regression testing.
     - **Node 3**: Executes deployment-related activities.
   - **Use Case**:
     - Suitable for large-scale projects with complex requirements.
   - **Advantages**:
     - Optimized resource utilization.
     - Reduced pipeline execution time.
   - **Challenges**:
     - Requires careful node configuration and management.

---

### 2. **Agents and Credentials**

---

#### **Agent Management**

1. **Components**:
   - **Master**:
     - The central Jenkins server that manages pipeline orchestration and task delegation.
   - **Slaves**:
     - Distributed nodes that execute the tasks assigned by the master.
     - Requirements:
       - **Java installation** is mandatory to establish communication with the master.

2. **Key Points**:
   - Use **Agent Labels** to assign tasks to specific agents based on their roles or capabilities.
   - Utilize **Node Labels** to specify the nodes on which certain pipeline stages should execute.
   - Pipelines typically execute tasks on slave nodes for efficient resource management.

---

#### **Credentials Management**

1. **Purpose**:
   - To securely store and manage sensitive information needed for pipeline execution, such as:
     - **SSH Keys**: Used for secure communication between systems.
     - **API Tokens**: Enable authentication and access to external services or APIs.
     - **Environment Variables**: Store reusable, sensitive data for consistent use across pipelines.

2. **Usage**:
   - Define credentials within Jenkins' credential management system.
   - Access credentials as secure variables in pipeline scripts.
   - Benefits:
     - Prevents unauthorized access to sensitive information.
     - Enhances security by avoiding hardcoding of secrets in pipeline scripts.
     - Ensures compliance with security best practices.

---

