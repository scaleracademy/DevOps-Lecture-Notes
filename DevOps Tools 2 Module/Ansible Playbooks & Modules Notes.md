# Ansible Playbooks & Modules Notes

## Agenda of the Lecture  

### **Topics to be Covered:**  
1. **Ad-Hoc Commands** – Running one-time commands without playbooks.  
2. **Playbooks** – Automating tasks using YAML-based scripts.  
3. **Playbook Structure** – Understanding how playbooks are written and executed.  
4. **Modules** – Exploring different modules that Ansible provides for automation.  
# **Ad-Hoc Commands**  

### **What are Ad-Hoc Commands?**  
- Ad-hoc commands allow executing simple, one-time tasks on remote machines **without writing a playbook**.  
- They are useful for quick administration tasks such as:  
  - Checking connectivity.  
  - Restarting a service.  
  - Copying files across multiple hosts.  
- Ad-hoc commands **target specific hosts or groups** and are executed directly from the command line.  

### **Key Components of an Ad-Hoc Command:**  
An ad-hoc command consists of the following parts:  

```bash
ansible <target-hosts> -m <module> -a "<arguments>"
```

| Component        | Description |
|-----------------|-------------|
| `ansible`       | The Ansible command. |
| `<target-hosts>` | The group of hosts or a single host (defined in inventory). |
| `-m <module>`   | Specifies the module (e.g., `ping`, `shell`, `copy`). |
| `-a "<arguments>"` | Arguments passed to the module. |


## **Examples of Ad-Hoc Commands**  

#### **1. Checking Connectivity with Remote Hosts**  
- The `ping` module is used to check if remote hosts are reachable.  
- If the connection is successful, it returns `"pong"`.  

```bash
ansible all -m ping
```

- **Output Example:**  

```json
server1 | SUCCESS => {
    "ping": "pong"
}
server2 | SUCCESS => {
    "ping": "pong"
}
```


#### **2. Running Shell Commands on Remote Hosts**  
- The `command` module allows executing shell commands on remote machines.  
- Example: Checking system uptime for `web_servers` group:  

```bash
ansible web_servers -m command -a "uptime"
```

- **Sample Output:**
  ```
  server1 | SUCCESS | rc=0 >>
   15:43:21 up 10 days,  3:22,  2 users,  load average: 0.03, 0.01, 0.00
  ```

#### **3. Copying Files from the Control Node to Remote Machines**  
- The `copy` module transfers files from the Ansible control node to remote hosts.  

```bash
ansible web_servers -m copy -a "src=control.txt dest=/tmp/control.txt"
```

- **How This Works:**  
  - The `src` parameter specifies the file on the control node.  
  - The `dest` parameter defines where to place the file on remote nodes.  

- **Behavior:**  
  - If the file does not exist, it will be copied.  
  - If the file exists and remains unchanged, no action is taken.  
  - If the file is different, it is replaced with the new version.  


### **Targeting Specific Hosts in Ad-Hoc Commands**  

1. **Using an Inventory File (`/etc/ansible/hosts`)**  
   - Define groups of servers:  
     ```
     [web_servers]
     server1
     server2
     ```
   - Run commands on this group:  
     ```bash
     ansible web_servers -m ping
     ```

2. **Specifying Inventory Directly in Command Line**  
   - Using a custom inventory file (`hosts.ini`):  
     ```bash
     ansible all -i hosts.ini -m ping -u ubuntu
     ```

# **Playbooks in Ansible**  

### **What is an Ansible Playbook?**  
- A playbook is a **YAML file** that defines a sequence of tasks to be executed on one or more remote machines.  
- Playbooks allow **automation of complex tasks**, ensuring **repeatability and consistency**.  

---

### **Why Use Playbooks Instead of Ad-Hoc Commands?**  

| Feature            | Ad-Hoc Commands | Playbooks |
|--------------------|---------------|------------|
| **Scope**         | Single, quick tasks | Multiple tasks in a structured workflow |
| **Reusability**   | Not reusable | Can be reused and version-controlled |
| **Idempotency**   | Not guaranteed | Ensures tasks run only if necessary |
| **Complexity Handling** | Limited | Supports loops, conditionals, and roles |

---

### **Structure of a Playbook**  

A playbook consists of **one or more plays**, where each play contains **tasks** that execute specific **modules**.  

#### **Basic Playbook Example**  

```yaml
- name: Configure Web Servers
  hosts: web_servers
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start Nginx Service
      service:
        name: nginx
        state: started
```

### **Key Components of a Playbook**  

1. **Hosts Section:**  
   - Specifies which hosts the playbook should target (e.g., `web_servers`).  

2. **Tasks:**  
   - Each playbook contains multiple tasks executed **sequentially** on the target hosts.  

3. **Modules:**  
   - Each task calls a **module** (e.g., `apt`, `copy`, `service`).  


# **Modules in Ansible**  

### **What Are Ansible Modules?**  
- Modules are **predefined scripts** that perform specific automation tasks.  
- Ansible modules are **stateless** – they only make changes if needed. 

# **Best Practices for Writing Playbooks**  

### **1. Use Descriptive Names for Tasks**  
- This improves readability and debugging.  
  ```yaml
  - name: Install Apache Web Server
    apt:
      name: apache2
      state: present
  ```

### **2. Ensure Idempotency**  
- Use **state:** to avoid unnecessary changes.  
  ```yaml
  - name: Start Apache if not running
    service:
      name: apache2
      state: started
  ```

### **3. Avoid Hardcoded Values - Use Variables**  
- Instead of:  
  ```yaml
  - name: Install a package
    apt:
      name: apache2
  ```
- Use variables:  
  ```yaml
  - name: Install a package
    apt:
      name: "{{ package_name }}"
  ```

### **4. Use Handlers for Services**  
- Handlers run **only if changes occur** in the playbook.  
  ```yaml
  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
  ```


## Practical Demo: Installing Apache with a Playbook  

### **Example Playbook - `Apache.yml`**  
- Targets the `web_servers` group.  
- Uses **become: yes** to execute tasks with root privileges.  

#### **Key Tasks in the Playbook:**  
1. **Install Apache** using the `apt` module.  
2. **Start Apache** using the `service` module.  
3. **Check Apache Status** using a shell command (non-idempotent).  

#### **YAML Configuration:**  
```yaml
- name: Install and Start Apache on Web Servers
  hosts: web_servers
  become: yes
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present

    - name: Start Apache Service
      service:
        name: apache2
        state: started

    - name: Check Apache Status
      shell: systemctl status apache2
```

## Understanding Task Idempotency  

- **Idempotency Principle:**  
  - Tasks that achieve the desired state should not report changes if already in that state.  
  - Example: If Apache is already installed, the `apt` task should report **ok** (not **changed**).  
- **Non-Idempotent Commands:**  
  - Shell commands execute every time, making them non-idempotent.  
  - Example:  
    ```yaml
    - name: Check Apache Status
      shell: systemctl status apache2
    ```  
    - This command runs every time and always reports changes. 

### **Commonly Used Modules in Playbooks**  

#### **1. File Module**  
- Manages files and directories.  
- Example: Create a directory:  
  ```yaml
  - name: Create application directory
    file:
      path: /opt/my_app
      state: directory
  ```  

#### **2. Package Module**  
- Installs or removes software packages.  
- Example: Install Apache:  
  ```yaml
  - name: Install Apache
    package:
      name: apache2
      state: present
  ```  

#### **3. Service Module**  
- Manages system services (start, stop, restart, enable).  
- Example: Ensure Apache is running:  
  ```yaml
  - name: Start Apache
    service:
      name: apache2
      state: started
  ```  

#### **4. User Module**  
- Manages user accounts on remote hosts.  

| Module | Purpose | Example |
|--------|---------|---------|
| `apt` | Installs or removes packages on Debian-based systems | Install Nginx: `apt: name=nginx state=present` |
| `yum` | Installs or removes packages on Red Hat-based systems | Install Apache: `yum: name=httpd state=present` |
| `service` | Starts, stops, or enables services | Start Nginx: `service: name=nginx state=started` |
| `copy` | Copies files from the control node to remote machines | Copy file: `copy: src=file.txt dest=/tmp/file.txt` |
| `file` | Manages file attributes (permissions, ownership) | Create directory: `file: path=/opt/data state=directory` |


## Task Execution & Parallelism  

### **Execution Flow:**  
- **Within a Single Host:** Tasks execute sequentially.  
- **Across Multiple Hosts:** Tasks can run in parallel (controlled by `forks`).  

### **Managing User Access:**  
- By default, Ansible connects using the **ansible_user** defined in the inventory.  
- You can override this using host-specific variables:  
  ```ini
  [web_servers]
  server1 ansible_user=ubuntu
  ```
  
### User and Host Variable Usage

- Default Behavior:
    - By default, Ansible may attempt to log in using a specific user (often defined in the inventory or configuration).
- Customizing Login User:
    - You can override the default login user using host variables like ansible_user to specify a different user per host.
- Example Scenario:
    - If a host is configured to use a non-root user for SSH and the playbook incorrectly attempts to log in as root, the connection may fail.
    - Correctly setting ansible_user in host-specific variables ensures proper authentication and task execution.
