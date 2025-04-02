# Templates, Variables & Facts

## Variables

### Variables in Ansible

- Variables in Ansible store values that can be used in playbooks and roles.
- They enable **dynamic configuration**, making playbooks reusable and flexible.
- Variable values can be defined at multiple levels, allowing for parameterization.

### Types of Variables in Ansible

#### **1. Host Variables**
- Host-specific variables apply to individual machines.
- Typically defined in:
  - Inventory files (`inventory.ini` or YAML-based inventory)
  - `host_vars/` directory with per-host variable files.
- Allow customization of host configurations dynamically.

#### **2. Group Variables**
- Define common settings for a group of hosts.
- Useful for managing configurations across multiple servers.
- Typically stored in:
  - Inventory files under the `[group_name]` section.
  - `group_vars/` directory with YAML files for each group.

---

## Inventory

### Introduction to Ansible Inventory

- An inventory file lists **managed nodes (hosts)** that Ansible controls.
- The default static inventory file is **`/etc/ansible/hosts`**.
- Dynamic inventory scripts (`inventory.ini` or external sources like AWS) can be used.

### YAML-Based Inventory

- An alternative to INI-based inventories is using a YAML-based format.
- YAML format improves readability and enables structured data representation.

#### **Example of a YAML-Based Inventory**
```yaml
all:
  hosts:
    webserver:
      ansible_host: 192.168.1.10
    database:
      ansible_host: 192.168.1.20
  children:
    web:
      hosts:
        webserver:
    db:
      hosts:
        database:
```

### Running Ansible Playbooks with YAML Inventories
```bash
ansible-playbook -i inventory.yaml playbook.yml
```

### Variable Precedence in Ansible

- When multiple variables are defined for the same entity, **precedence** determines which value is applied.

#### **Hierarchy of Variable Precedence (Lowest to Highest)**
1. **Default variables** (inside roles)
2. **Inventory variables** (defined in `inventory.ini` or YAML-based inventory)
3. **Group variables** (`group_vars/`)
4. **Host variables** (`host_vars/`)
5. **Playbook variables** (directly assigned within a playbook)
6. **Registered variables** (created during playbook execution)
7. **Extra variables** (passed via CLI using `-e` flag)

Example of passing extra variables:
```bash
ansible-playbook playbook.yml -e "var_name=value"
```

---

## Facts

### Understanding Facts in Ansible

- **Facts** are system properties automatically gathered by Ansible from remote hosts.
- Examples of gathered information:
  - Network configuration
  - Operating system details
  - Hardware specifications
- Facts allow conditional execution of tasks based on host characteristics.

#### **Example of Using Facts in a Playbook**
```yaml
- name: Install web server based on OS
  hosts: all
  tasks:
    - name: Install httpd on RHEL-based systems
      yum:
        name: httpd
        state: present
      when: ansible_os_family == "RedHat"

    - name: Install apache2 on Debian-based systems
      apt:
        name: apache2
        state: present
      when: ansible_os_family == "Debian"
```

### Disabling Fact Gathering

#### Why Disable Fact Gathering?
- **Optimizes playbook execution time** by skipping fact collection.
- **Reduces system load** on remote machines.
- Suitable when facts are not required for task execution.

#### **How to Disable Fact Gathering**
- Use `gather_facts: no` in the playbook:
```yaml
- name: Playbook without facts gathering
  hosts: all
  gather_facts: no
  tasks:
    - name: Execute command without facts
      command: echo "Hello, Ansible!"
```

---

## Defining Custom Facts

### Creating Custom Facts

- Custom facts allow administrators to define **additional system properties**.
- Can be stored as:
  - **Executable scripts** (e.g., Bash or Python)
  - **Static JSON files** inside `/etc/ansible/facts.d/`

#### **Example: Defining a Custom Fact in JSON Format**
1. Create a custom facts file:
```bash
mkdir -p /etc/ansible/facts.d/
echo '{"app_version": "2.0"}' > /etc/ansible/facts.d/custom_fact.json
```
2. Retrieve the fact using Ansible:
```yaml
- name: Display custom fact
  hosts: all
  tasks:
    - name: Fetch app version
      debug:
        msg: "Application Version: {{ ansible_local.custom_fact.app_version }}"
```

### **Use Case: Ensuring Correct Software Version**
- If a new **V2 application** requires **Nginx 1.2**, the playbook can:
  - Check which servers run **V2**.
  - Install or update Nginx accordingly.

### **Alternative: Registering a Custom Fact Dynamically**
Instead of static facts, you can **register a variable** during playbook execution:

```yaml
- name: Gather custom facts dynamically
  hosts: all
  tasks:
    - name: Register application version
      shell: echo "2.0"
      register: app_version

    - name: Print application version
      debug:
        msg: "App Version: {{ app_version.stdout }}"
```

---

## Jinja2 Templating

### Introduction to Jinja2 Templates

- **Jinja2** is a templating engine used in Ansible for dynamic content generation.
- It allows embedding **variables, loops, and conditions** inside configuration files.

#### **Basic Syntax**
```jinja2
{{ variable_name }}   # Prints the value of a variable
{% if condition %}    # Conditional statements
{% for item in list %}  # Looping constructs
```

#### **Example: Using Jinja2 in an Ansible Template**
1. Create a Jinja2 template (`nginx.conf.j2`):
```jinja2
server {
    listen 80;
    server_name {{ server_name }};
    location / {
        root {{ document_root }};
    }
}
```
2. Apply the template in a playbook:
```yaml
- name: Deploy Nginx configuration
  hosts: web
  tasks:
    - name: Render nginx.conf from template
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
```

---
