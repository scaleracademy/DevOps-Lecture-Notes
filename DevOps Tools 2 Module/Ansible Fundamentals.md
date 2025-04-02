# Ansible Fundamentals
In this session, we will be covering the following topics related to Ansible fundamentals:

- **Configuration as Code**
  Discuss how infrastructure is managed with machine-readable definition files to achieve consistency, scalability, and automation.
- **Ansible Overview**  
  Introduction to Ansible as a tool for automation, configuration management, and how it compares to Chef and Puppet.
- **Installation**  
  Guide to setting up Ansible and configuring control/managed nodes.
- **Server Setup**  
  Steps to configure servers using Ansible for infrastructure automation.
- **Adhoc Commands**  
  Explanation of quick and temporary commands for one-off tasks in Ansible.


### Configuration as Code

**Definition:**  
Configuration as Code is the practice of managing and provisioning infrastructure through machine-readable definition files, rather than through physical hardware configuration or interactive configuration tools.

**Key Benefits:**

- **Consistency**  
  Ensures identical environments across development, testing, and production.
- **Version Control**  
  Infrastructure changes are tracked, just like source code.
- **Scalability**  
  Easy to replicate infrastructure for scaling up or down.
- **Automation**  
  Allows for automated setup and configuration without manual intervention.

**Popular Tools:**
- Chef
- Puppet
- Ansible

### Comparison of Chef, Puppet, and Ansible

| Feature              | Chef                | Puppet              | Ansible           |
|----------------------|---------------------|---------------------|-------------------|
| **Language**          | Ruby (DSL)          | Puppet DSL          | YAML (Playbooks)  |
| **Model**             | Pull                | Pull                | Push              |
| **Agent Required**    | Yes                 | Yes                 | No                |
| **Ease of Use**       | Medium              | Medium              | Easy              |
| **Control Node**      | Chef Server         | Puppet Master       | Control Machine   |
| **Managed Nodes**     | Chef Clients (Agent)| Puppet Agents (Agent)| Agentless (SSH)   |
| **Configuration**     | Cookbooks/Recipes   | Manifests/Modules   | Playbooks/Roles   |
| **Scalability**       | High                | High                | Moderate          |


### Ansible Overview

**Definition:**  
Ansible is an open-source automation tool that simplifies IT orchestration by offering an agentless architecture. It manages configurations, deployment, and infrastructure tasks.

#### Key Concepts:

- **Playbooks**  
  YAML files that describe the desired state of your infrastructure. For example, installing Nginx on a server can be defined in a playbook, and Ansible will match the server’s configuration to this desired state.

- **Modules**  
  Reusable standalone scripts that perform specific tasks. For example, the `apt` module installs packages on Debian systems.

  Types of modules:
  - Core module (e.g., apt)
  - Custom module (user-created)

- **Inventory**  
  A list of managed nodes (servers) that Ansible will configure. Inventory is often a simple text file.

- **Templates**  
  Use variables and logic to create dynamic configurations that adapt based on server or environment specifics.

- **Roles**  
  A method for organizing playbooks and tasks into reusable components. These help to structure your Ansible code for better readability and maintenance.

### Ansible Architecture

**Overview:**  
Ansible uses a control node and managed nodes to perform its tasks. The control node sends instructions (playbooks) via SSH to managed nodes without needing any agents.

**Flow of Operation:**

1. Write the playbook defining the desired state.
2. Define the inventory (managed nodes) and group the servers as needed.
3. Run the playbook from the control node.
4. Ansible connects to the managed nodes via SSH and executes the required modules.
5. The output is displayed after completion.

![Ansible Architecture](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/110/156/original/ansiblearch.png?1739985222)

**Use Cases of Ansible:**

- Configuration Management
- Application Deployment
- Continuous Delivery


### Instructor Notes for Demo:

- **Setup:**  
  Ensure you have access to the control node from a local machine via SSH. The control node must be able to connect to the managed nodes.

- **Key Steps for Setup:**
  1. Copy the public key from the control node to the managed nodes' authorized keys.
  2. Options for setting up SSH:
     - Manually copy the public key from the control node to each managed node.
     - Use a PEM file to log in to managed nodes from the control node and then copy the public key.

