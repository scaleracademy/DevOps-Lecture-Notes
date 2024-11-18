# System Access Management

## Agenda of the Lecture
### Small Quiz
**Question:** You are currently in the `bin` directory and want to copy a file named `abc.txt` from the same directory to a directory named `test` located in `/tmp`. Which command is correct?
- `cp bin/abc.txt /tmp/test/`
- `cp /tmp/test/abc.txt bin`
- `mv bin/abc.txt /tmp`
- **`cp abc.txt /tmp/test/`**

**Answer Explanation:** The correct command is `cp abc.txt /tmp/test/`. Since you are already in the `bin` directory, you only need to specify the filename and the destination path. The other options either incorrectly position the source and destination or use the wrong command.

### Lecture Agenda
Today's discussion will cover:
- **Multiuser Linux**:
    - How to create and manage users.
    - Managing permissions associated with users and groups.
- **Sudo and Setfacl**:
    - Granting elevated permissions using `sudo`.
    - Managing file access control lists with `setfacl`.
- **Processes**:
    - Understanding and managing processes in Linux.

---

## Users and Groups

### Linux User Management
Linux is designed to support both single-user and multi-user environments, efficiently managing multiple users with distinct permissions.

#### Users
- Each user in Linux has a unique **username** and **user ID**.
- To find the current username, use the command:
    ```bash
    whoami
    ```

#### Groups
- Groups are a way to manage multiple users collectively. Users within the same group share certain permissions.
- For example, in a company, employees might be divided into groups like Trainees, Engineering, and HR, each with specific access rights.
- In Linux, groups function similarly, allowing for collective permission management.
- To check which groups exist, use the command:
    ```bash
    cat /etc/group
    ```

#### Ownership
- Every file or directory in Linux has an owner, who has specific permissions. By default, the user who creates a file or directory is its owner, but ownership can be transferred to another user.

### Practical Session on User and Group Management

#### Viewing Users and Groups
- To view the list of users:
    ```bash
    cat /etc/passwd
    ```
- To view the list of groups:
    ```bash
    cat /etc/group
    ```

#### Creating Users
- Use the following command to create a new user:
    ```bash
    useradd <username>
    ```
- If you encounter permission issues, prepend `sudo` for root-level operations:
    ```bash
    sudo useradd <username>
    ```

#### Verifying User Creation
- To verify that a user has been created, you can search for the username in the `/etc/passwd` file:
    ```bash
    grep <username> /etc/passwd
    ```
- For a case-insensitive search, add the `-i` flag:
    ```bash
    grep -i <username> /etc/passwd
    ```

#### Assigning Passwords
- Assign a password to a user with the following command:
    ```bash
    sudo passwd <username>
    ```

#### Switching Users
- To switch to another user:
    ```bash
    su <username>
    ```
- After switching, confirm the current user by running:
    ```bash
    whoami
    ```

#### Creating and Managing Groups
- To create a new group:
    ```bash
    sudo groupadd <groupname>
    ```
- To assign a user to a group:
    ```bash
    sudo usermod -aG <groupname> <username>
    ```
- To delete a group:
    ```bash
    sudo groupdel <groupname>
    ```

---

## File Permissions

### Understanding File Permissions
**[Instructor Note]:** Execute the following command to display file permissions and explain the output:
```bash
ls -ltra
```
- File permissions in Linux are represented by a combination of `r`, `w`, and `x`:
    - `r` stands for **read**.
    - `w` stands for **write**.
    - `x` stands for **execute**.
- The permissions are divided into three categories: **user**, **group**, and **others**. The order of priority starts with the user, then group, and finally others.
- A file with `l` in its permission set indicates that it is a **soft link**.

### Commands for Managing Permissions
#### Changing Ownership
- To change the ownership of a file or directory to a specific user:
    ```bash
    sudo chown <username> <filename>
    ```

#### Changing Group Ownership
- To change the group ownership:
    ```bash
    sudo chown :<groupname> <filename>
    ```

#### Changing Both User and Group Ownership
- To change both user and group ownership simultaneously:
    ```bash
    sudo chown <username>:<groupname> <filename>
    ```

#### Changing File Permissions
- To add read, write, and execute permissions for the user:
    ```bash
    chmod u+rwx <filename>
    ```
- To add the same permissions for the group:
    ```bash
    chmod g+rwx <filename>
    ```

### Numerical Representation of Permissions
- File permissions can also be set using a numeric system:
    - `r` has a value of `4`.
    - `w` has a value of `2`.
    - `x` has a value of `1`.
- For example, the permission set `rwxrw-r--` corresponds to:
    - User: `4+2+1 = 7`
    - Group: `4+2+0 = 6`
    - Others: `4+0+0 = 4`
- To set these permissions, use:
    ```bash
    chmod 764 <filename>
    ```

---

## Setfacl and Sudo Commands

### Setfacl Command
The `setfacl` command is used to set **file access control lists (ACLs)**, which allow more fine-grained permission control compared to standard Linux file permissions.

- To give a specific user read and write access to a file:
    ```bash
    setfacl -m u:<username>:rw <filename>
    ```
- **Difference from Other Commands**:
    - `chown` changes ownership.
    - `chmod` modifies the mode (permissions) for user, group, and others.

### Getfacl Command
The `getfacl` command displays the ACLs for a file or directory, showing which users and groups have specific permissions.
```bash
getfacl <filename>
```

### Sudo Command
`sudo` (Super User Do) is a command that allows permitted users to execute commands that require root privileges.

- **Purpose**:
    - It temporarily elevates user privileges to execute administrative tasks.
    - **Analogy**: Just as Dr. Banner transforms into the Hulk for extra strength, `sudo` gives users temporary superuser privileges.

#### Assigning Sudo Permissions
- To add a user to the sudo group:
    ```bash
    sudo usermod -aG sudo <username>
    ```

* Try accessing the `/etc/sudoers` file, first without `sudo` (to show permission denial) and then with `sudo` to open it successfully:
```bash
vi /etc/sudoers
sudo vi /etc/sudoers
```

- To grant a specific user full sudo permissions, add the following line to the `/etc/sudoers` file:
    ```bash
    <username> ALL=(ALL) ALL
    ```

- If you want to allow the user to execute sudo commands without entering a password, modify the line to:
    ```bash
    <username> ALL=(ALL) NOPASSWD: ALL
    ```

- To assign sudo access to an entire group:
    ```bash
    %<groupname> ALL=(ALL) ALL NOPASSWD: ALL
    ```

---

## Small Project

### Assignment for Practice
**Scenario:** You are a DevOps engineer tasked with setting up the development environment for a new application project. The project team includes developers, testers, and project managers.

**Requirements**:
1. **Developers**: 
    - Should have access to the source code and deployment capabilities on servers.
2. **Testers**: 
    - Should have access to the testing environment but **cannot modify** the source code.
3. **Project Managers**:
    - Can view access reports and monitor progress but **cannot modify** the code.

**Tasks**:
1. Create groups according to the roles.
2. Create users and assign them to the appropriate groups.
3. Create directories named `project`, `testing`, and `reports`.
4. Assign correct ownership and permissions to these directories to match the required access control.

