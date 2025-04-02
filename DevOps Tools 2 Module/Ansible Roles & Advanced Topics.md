# Ansible Roles & Advanced Topics

## **Jinja2 Templating**
- Jinja2 is a powerful templating engine for Python, used by Ansible to manage configuration files dynamically.
- It allows generating dynamic content and manipulating data efficiently.
- Useful for creating configuration files for different environments.

### **Example Use Case**
If managing an Apache server where each server needs different virtual host configurations, Jinja2 allows using a single template. At runtime, Ansible fills in details specific to each server.

### **Jinja2 Syntax**
- Variables: `{{ variable_name }}`
- Logical Statements: `{% logic %}`

#### **Example Jinja2 Template for Apache VirtualHost**
```apache
<VirtualHost *:80>
    ServerName {{ server_name }}
    {% for alias in server_aliases %}
    ServerAlias {{ alias }}
    {% endfor %}
    DocumentRoot {{ document_root }}
    ErrorLog {{ error_log }}
    CustomLog {{ custom_log }} combined
</VirtualHost>
```
This template dynamically generates an Apache VirtualHost configuration.

### **Jinja2 in Ansible Playbooks**
```yaml
- name: Deploy Apache VirtualHost configuration
  hosts: webservers
  become: yes
  vars:
    server_name: "example.com"
    server_aliases:
      - "www.example.com"
      - "example.org"
    document_root: "/var/www/html"
    error_log: "/var/log/apache2/error.log"
    custom_log: "/var/log/apache2/access.log"

  tasks:
    - name: Deploy VirtualHost configuration file
      template:
        src: apache_virtualhost.j2
        dest: /etc/apache2/sites-available/000-default.conf
        mode: '0644'
```

---

## **Prompting for Variables**
- Instead of hardcoding variables, Ansible allows prompting users for input at runtime using `vars_prompt`.

#### **Example: Prompting for User Input**
```yaml
- name: Prompt for variables
  hosts: localhost
  gather_facts: no
  vars_prompt:
    - name: username
      prompt: "Enter the username"
      private: no

  tasks:
    - name: Display entered username
      debug:
        msg: "The username is {{ username }}"
```

---

## **Roles in Ansible**
- Roles provide a structured way to organize Ansible playbooks into reusable components.
- This makes automation code modular, scalable, and easier to maintain.

### **Example: A Web Server Role**
A role for setting up a web server might include:
- Installing the web server
- Configuring it
- Ensuring it runs

### **Ansible Role Directory Structure**
```
roles/
└── my-role/
    ├── tasks/
    │   └── main.yml
    ├── vars/
    │   └── main.yml
    ├── handlers/
    │   └── main.yml
    ├── templates/
    │   └── main.yml
    ├── defaults/
```
- Instead of keeping everything in a single playbook, roles help modularize automation tasks.

---

## **Ansible Galaxy**
- **Ansible Galaxy** is a platform for sharing and downloading Ansible roles.
- Helps reuse existing roles instead of creating everything from scratch.

### **Common Ansible Galaxy Commands**
- **Creating a new role:**
  ```bash
  ansible-galaxy init [role_name]
  ```
- **Installing predefined roles:**
  ```bash
  ansible-galaxy install [role_name]
  ```
- **Listing installed roles:**
  ```bash
  ansible-galaxy list
  ```

---

## **Conditions & Loops in Ansible**

### **Conditions in Ansible**
#### **Using `when` for Conditional Execution**
```yaml
- name: Ensure httpd is installed
  yum:
    name: httpd
    state: present
  when: ansible_facts["os_family"] == "RedHat"
```

#### **AND Condition**
```yaml
when:
  - ansible_facts["os_family"] == "RedHat"
  - ansible_facts["open-in"] >= 0
```

#### **OR Condition**
```yaml
when:
  - ansible_facts["os_family"] == "RedHat" or ansible_facts["os_family"] == "Debian"
```

### **Loops in Ansible**
Ansible supports loops using:
1. `with_items` (older approach)
2. `loop` (recommended approach)

#### **Example: Installing Multiple Packages**
Using `with_items`:
```yaml
- name: Install packages
  apt:
    name: "{{ item }}"
    state: present
  with_items:
    - git
    - curl
    - nginx
```

Using `loop`:
```yaml
- name: Install packages
  apt:
    name: "{{ item }}"
    state: present
  loop:
    - git
    - curl
    - nginx
```

#### **Looping Over Dictionaries**
```yaml
- name: Create users with groups
  user:
    name: "{{ item.name }}"
    groups: "{{ item.groups }}"
  loop:
    - { name: "deepak", groups: "admin" }
    - { name: "dev", groups: "dev" }
```
This dynamically creates users and assigns them specified groups.

---
