# Typed Notes: Ansible Vault & Best Practices

## Tags in Ansible

- **Tags** are labels assigned to tasks, plays, and roles in Ansible. They allow for control over which tasks or plays are executed in a playbook.
- Tags enable running specific parts of a playbook without executing the entire script. This is useful when you need to execute only certain tasks, like installation or configuration.

### Example of Tags Usage:
```yaml
- name: Install Software
  yum:
    name: my_software
    state: present
  tags:
    - install

- name: Configure Software
  template:
    src: config.j2
    dest: /etc/my_software/config.conf
  tags:
    - config

- name: Deploy Software
  shell: /usr/local/bin/deploy.sh
  tags:
    - deploy
```

To run tasks based on tags:
```bash
ansible-playbook playbook.yml --tags install   # Runs only tasks with the "install" tag
ansible-playbook playbook.yml --skip-tags install   # Skips tasks with the "install" tag
ansible-playbook playbook.yml --tags "install,config"   # Runs tasks with either "install" or "config" tags
```

### Why Use Tags:
- They improve efficiency in large playbooks.
- Tags help skip unnecessary tasks and focus on relevant operations, such as install, config, or deploy.

---

## Handlers in Ansible

- **Handlers** are special tasks in Ansible that only run when notified by other tasks. These tasks typically perform actions like restarting services or reloading configurations, which should only happen after a change is made.
- Handlers are triggered when a task notifies them, and they ensure that a task is executed only when necessary.

### Example of Handlers:
```yaml
- name: Configure Nginx
  hosts: webservers
  become: yes  # Run tasks with sudo privileges
  tasks:
    - name: Deploy Nginx configuration
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
        owner: root
        group: root
        mode: '0644'
      notify: Restart Nginx

handlers:
  - name: Restart Nginx
    service:
      name: nginx
      state: restarted
```

### Practical Use Case:
- Restart services only after configuration changes.
- Handlers help avoid unnecessary service restarts, reducing interruptions in your environment.

---

## Ansible Vault

- **Ansible Vault** is a feature that encrypts sensitive data, such as passwords, API keys, and private information, within playbooks or variable files.
- It ensures sensitive data is stored securely, preventing exposure in plain text while still allowing safe sharing and automation.
  
### Basic Commands for Ansible Vault:
- `ansible-vault encrypt <file_name>`: Encrypt a file.
- `ansible-vault decrypt <file_name>`: Decrypt a file.
- `ansible-vault edit <file_name>`: Edit an encrypted file without decrypting it.

### Usage Example:
- **Using a password file** to run a playbook with encrypted content:
```bash
ansible-playbook --vault-password-file path-to-file
```

- Best practice is to **exclude** password files from version control using `.gitignore`.

---

## Error Handling in Ansible

1. **Increasing Verbosity**:
   - The `-v`, `-vv`, and `-vvv` flags allow you to control the verbosity of the output when running a playbook.
     - `-v`: Basic output.
     - `-vv`: More detailed output.
     - `-vvv`: The most detailed output, helpful for debugging.

2. **Dry Run Mode (`--check`)**:
   - The `--check` option allows you to simulate the execution of a playbook without making any changes, which is useful for validation.
   - Example:
   ```bash
   ansible-playbook playbook.yml --check
   ```

   Example Playbook with `--check`:
   ```yaml
   - name: Install and Start NGINX
     hosts: webservers
     become: yes
     tasks:
       - debug:
           msg: "This is a DRY RUN, no changes will be made!"
         when: ansible_check_mode

       - name: Install NGINX
         package:
           name: nginx
           state: present

       - name: Start and Enable NGINX
         service:
           name: nginx
           state: started
           enabled: yes
   ```

   **With `--check`**: The playbook will simulate changes but not apply them.
   **Without `--check`**: The playbook will apply the changes (install and start NGINX).

---

## Best Practices in Ansible

### 1. **Directory Layout**:
- **Separation of Environments**: Maintain separate configurations for different environments, like `production` and `staging`.
- **Group and Host Variables**: Use `group_vars` and `host_vars` for environment-specific or host-specific configurations.
- **Roles**: Organize tasks into reusable roles (`common`, `webservers`, `python`) to promote modularity and easier maintenance.
- **Main Playbook**: The `main.yml` serves as the entry point for the automation process, ensuring clarity and structure.

### 2. **Reusability and Modularity**:
- Break tasks into reusable, self-contained units using roles.
- Store environment or host-specific configurations in `group_vars` and `host_vars` for better flexibility.
- Use `when` conditions to apply tasks conditionally.

### 3. **Performance Optimization**:
- Use `async` and `poll` to handle long-running tasks asynchronously.
  
Example:
```yaml
- name: Restart Nginx
  service:
    name: nginx
    state: restarted
  async: 300  # Run asynchronously with a maximum execution time of 300 seconds
  poll: 0      # Do not wait for completion, continue with other tasks
```

- **Caching Facts**: Cache facts to speed up the process of gathering data from remote hosts.
