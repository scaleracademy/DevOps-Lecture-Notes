# Introduction to Concurrency
## **Assignment Answer: Group and User Management**

### **Step 1: Creating Groups**

In a multi-user environment, managing permissions and access control is crucial. One of the primary ways to manage this is through groups. Groups allow you to assign a set of permissions to multiple users simultaneously, making it easier to manage who can access what.

- **Creating User Groups:**
  - The command `sudo groupadd <group_name>` is used to create a new group in the system.
  - **Example Commands:**
    ```bash
    sudo groupadd developers
    sudo groupadd testers
    sudo groupadd project_managers
    ```
    - **Explanation:**
      - `developers`: A group intended for users who are developers, giving them access to relevant resources and directories.
      - `testers`: A group for testers, ensuring they have the appropriate permissions for testing-related files and tools.
      - `project_managers`: A group for project managers, who may need broader access to project-related files.

  - **Why This is Important:**
    - By organizing users into groups, you streamline the process of assigning and managing permissions. Instead of setting permissions individually for each user, you can assign permissions to a group and then add users to that group as needed.

### **Step 2: Creating Users**

Users are individual accounts that allow people to access the system. Each user account can be assigned to one or more groups, which determines what files and directories they can access.

- **Creating User Accounts:**
  - The command `sudo useradd <username>` is used to create a new user.
  - **Example Commands:**
    ```bash
    sudo useradd dev_1
    sudo useradd test_1
    sudo useradd pm_1
    ```
    - **Explanation:**
      - `dev_1`: A user account for a developer. This user can be added to the `developers` group to inherit the permissions associated with that group.
      - `test_1`: A user account for a tester, which can be added to the `testers` group.
      - `pm_1`: A user account for a project manager, which can be added to the `project_managers` group.

  - **Interchangeability of Steps 1 and 2:**
    - It’s important to note that groups and users can be created in any order. The sequence does not impact functionality. You can create users first and assign them to groups later, or create groups first and then add users to them.

### **Step 3: Creating Directories**

Directories (folders) are used to organize files on the system. In a collaborative environment, you often need to create directories that are shared among users in a specific group.

- **Creating Directories for Group Access:**
  - The `mkdir` command is used to create directories. The `-p` option ensures that parent directories are created as needed.
  - **Example Command:**
    ```bash
    sudo mkdir -p /var/html/developer
    ```
    - **Explanation:**
      - This command creates a directory at `/var/html/developer`, intended for use by the `developers` group. Similar directories should be created for `testers` and `project_managers`.
      - The `-p` option is particularly useful when you need to create a directory structure, where parent directories might not already exist.

  - **Best Practices:**
    - It’s advisable to carefully plan your directory structure before creating directories to ensure that files are organized logically. This reduces confusion and makes it easier to manage permissions later on.

### **Step 4: Setting Group Ownership**

After creating directories, it’s essential to assign them to the correct group. This step ensures that only members of the intended group have access to the directory.

- **Assigning Directory Ownership to a Group:**
  - The `chown` command changes the ownership of files and directories. The `-R` option applies the ownership change recursively, affecting all files and subdirectories within the specified directory.
  - **Example Command:**
    ```bash
    sudo chown -R :developers /var/html/developer
    ```
    - **Explanation:**
      - This command assigns ownership of the `/var/html/developer` directory and all its contents to the `developers` group. The colon `:` before the group name indicates that we’re setting the group ownership, not changing the user ownership.
      - **Dependency:** This step assumes that the directory `/var/html/developer` and the `developers` group have already been created. If they don’t exist, the command will fail.

  - **Why Group Ownership Matters:**
    - Setting the correct group ownership is crucial for maintaining security and ensuring that only the intended users can access or modify the files within the directory.

### **Step 5: Setting Permissions**

Permissions determine who can read, write, or execute files within a directory. By setting appropriate permissions, you control access to sensitive data and ensure that users can only perform actions they are authorized for.

#### **Example 1: Setting Permissions for the Developer Directory**

- **Setting Permissions:**
  - The `chmod` command is used to set file and directory permissions. The `-R` option applies the permissions recursively.
  - **Example Command:**
    ```bash
    sudo chmod -R 770 /var/html/developer
    ```
    - **Explanation:**
      - **7 (rwx) for User:** The user who created the directory has full permissions: read, write, and execute. This is standard since the user often needs to manage the directory.
      - **7 (rwx) for Group:** The `developers` group has full permissions. This allows any member of the group to access, modify, and execute files within the directory.
      - **0 for Others:** No permissions are granted to other users outside the `developers` group. This ensures that only authorized users can access the directory, enhancing security.

#### **Example 2: Setting Permissions for the Report Directory**

- **Setting Permissions for Broader Access:**
  - **Example Command:**
    ```bash
    sudo chmod -R 774 /var/html/report
    ```
    - **Explanation:**
      - **7 (rwx) for User:** The project manager (PM group) has full permissions to manage the report directory.
      - **7 (rwx) for Group:** The `PM group` also has full permissions, allowing any member of the project managers to access and modify the files.
      - **4 (r-- ) for Others:** Developers and testers have read-only access. This allows them to view reports without making changes, which is crucial for maintaining the integrity of the reports while still providing access to those who need it.

  - **Balancing Access:**
    - This permission setting balances the need for broad access (by allowing read permissions) with the need to maintain control over who can modify the content.

---

## **Using Find and Grep Commands in Shell Scripting**

### **Find Command**

The `find` command is a powerful utility in Linux for locating files and directories based on various criteria. It is particularly useful in large filesystems where manual searching would be impractical.

- **Purpose and Functionality:**
  - The `find` command searches the filesystem starting from a specified directory. You can filter the search based on file name, type, modification date, size, and more.
  - **Basic Syntax:**
    ```bash
    find <path> -name <filename>
    ```
    - **Explanation:**
      - `<path>`: The starting point for the search. It can be a specific directory or `/` for the entire filesystem.
      - `-name`: A common option to search for files by name, supporting wildcards (e.g., `*.txt`).
      - `<filename>`: The name or pattern of the file you’re searching for.

  - **Example Usage:**
    ```bash
    find /home -name "*.txt" -mtime 7
    ```
    - **Explanation:**
      - This command searches the `/home` directory (and its subdirectories) for files with a `.txt` extension that were modified in the last 7 days.
      - **-mtime 7:** The `-mtime` option filters files based on the last modification time. In this example, it finds files modified exactly 7 days ago. Using `+7` or `-7` would find files modified more than or less than 7 days ago, respectively.

  - **Use Cases:**
    - **Locating Recently Modified Files:** Useful for finding files that have changed recently, which can be critical in debugging or version control.
    - **Cleaning Up Old Files:** Administrators can use `find` to identify and remove old or unnecessary files, helping to manage disk space.

### **Grep Command**

The `grep` command is used to search through text files for specific patterns, making it an essential tool for parsing logs, configuration files, and code.

- **Purpose and Functionality:**
  - `grep` searches through the content of a file, looking for lines that match a specified pattern. It can also search across multiple files and directories.
  - **Basic Syntax:**
    ```bash
    grep <pattern> <file>
    ```
    - **Explanation:**
      - `<pattern>`: The string or regular expression you want to search for.
      - `<file>`: The file in which to search. You can specify multiple files or use wildcards to search in multiple files at once.

  - **Example Usage:**
    ```bash


    grep -i "error.*html" /var/log/scalar.log
    ```
    - **Explanation:**
      - **-i:** This option makes the search case insensitive, so `grep` will match "error" regardless of whether it appears as "ERROR", "Error", or "error".
      - **"error.*html"**: This pattern uses regular expressions to search for lines containing the word "error" followed by any characters (indicated by `.*`) and then "html".
      - **/var/log/scalar.log:** The file to be searched, typically a log file in this case.

  - **Use Cases:**
    - **Log File Analysis:** System administrators frequently use `grep` to find specific errors or events in log files, which can be critical for troubleshooting.
    - **Code Search:** Developers use `grep` to find occurrences of variables, functions, or comments in source code, making it easier to navigate large codebases.

### **Difference in Usage: Find vs. Grep**

- **Find Command:**
  - **Primary Use:** Locating the existence of files or directories within the file system.
  - **Example Scenario:** If you need to find a log file named `scalar.log` somewhere within the `/home` directory, you would use `find`.
  - **Advantages:** Excellent for file discovery, especially when the exact location of the file is unknown.

- **Grep Command:**
  - **Primary Use:** Searching for specific patterns within the content of a file.
  - **Example Scenario:** If you have found the `scalar.log` file and need to identify lines containing the word "error", `grep` would be the tool to use.
  - **Advantages:** Ideal for parsing through text files and extracting relevant information based on patterns.

  - **Combined Usage:**
    - Often, `find` and `grep` are used together. First, `find` locates the files, and then `grep` searches within those files for specific patterns. This combination is powerful for comprehensive searches within large systems.

---

## **Softlink and Hardlink**

### **Understanding Links in Linux Filesystems**

In Linux, links are references to files. There are two main types: soft (symbolic) links and hard links. Each serves a different purpose and behaves differently under various conditions.

### **Soft Link (Symbolic Link)**

- **Definition:**
  - A **soft link** is essentially a shortcut to another file. It’s a special type of file that points to the location of another file or directory.
  - **Behavior:**
    - Acts as a reference: A soft link does not contain the data of the file itself, only a pointer to the file.
    - **File Deletion:** Deleting a soft link does not affect the original file. However, if the original file is deleted, the soft link becomes a "broken link" and no longer functions.
    - **Use Case:** Soft links are useful when you need to create shortcuts to files that reside in different directories, especially when you want to access the same file from multiple locations.

- **Example in Linux:**
  ```bash
  ln -s /path/to/original /path/to/softlink
  ```
  - **Explanation:**
    - `ln -s` creates a symbolic (soft) link from the original file to a new location. The `-s` flag indicates that the link is symbolic.
    - **Practical Example:**
      - If you have a configuration file located in `/etc/config/app.conf` and you want easy access from your home directory, you can create a soft link in your home directory pointing to this file.

  - **Analogy:**
    - In Windows, this is akin to creating a desktop shortcut to a file located elsewhere on your system.

### **Hard Link**

- **Definition:**
  - A **hard link** is a direct reference to the data of a file on the disk. Unlike soft links, hard links share the same inode as the original file, meaning they are exact duplicates of the file.
  - **Behavior:**
    - **File Deletion:** Deleting the original file does not delete the data or the hard link because both the original file and the hard link are just pointers to the same data blocks on the disk.
    - **Data Synchronization:** Changes made to the original file or the hard link are reflected in both, as they both reference the same data.
    - **Use Case:** Hard links are useful for ensuring data integrity when multiple references to the same data are required. This is common in backup systems and version control where maintaining identical copies of files in different locations is necessary.

- **Example in Linux:**
  ```bash
  ln /path/to/original /path/to/hardlink
  ```
  - **Explanation:**
    - The `ln` command without the `-s` flag creates a hard link. Both the original and the hard link point to the same data blocks on the disk.
    - **Practical Example:**
      - If you create a hard link for a file `document.txt` in another directory, you can edit `document.txt` from either location, and the changes will appear in both.

  - **Special Considerations:**
    - **Hard Links and File Integrity:** Since hard links point to the same data, they are essential in environments where data integrity and redundancy are critical. For example, in a situation where you want to ensure that a file’s data remains accessible even if the original file is deleted or moved.

### **Practical Demonstration of Creating Links**

### **Creating a Soft Link**

1. **Create an Original File:**
   - First, create a file that you will link to:
   ```bash
   vi originalfile.txt
   chmod 777 originalfile.txt
   ```
   - **Explanation:**
     - `vi originalfile.txt` creates and opens a file named `originalfile.txt` for editing.
     - `chmod 777 originalfile.txt` gives all users read, write, and execute permissions on the file, ensuring that it’s fully accessible.

2. **Create the Soft Link:**
   - Create a soft link that points to the original file:
   ```bash
   ln -s /path/to/originalfile.txt /path/to/softlink.txt
   ```
   - **Explanation:**
     - This command creates a symbolic link at `/path/to/softlink.txt` that points to `/path/to/originalfile.txt`.

3. **Verify the Link:**
   - You can check the existence and status of the soft link with:
   ```bash
   ls -ltra
   ```
   - **Explanation:**
     - `ls -ltra` lists all files and directories in the current directory, showing symbolic links and their targets.

4. **Test the Soft Link by Deleting the Original File:**
   - Delete the original file to see the effect on the soft link:
   ```bash
   rm /path/to/originalfile.txt
   ```
   - **Outcome:**
     - The soft link remains, but it becomes non-functional because the original file it points to no longer exists.

### **Creating a Hard Link**

1. **Create an Original File:**
   - Start by creating the original file:
   ```bash
   touch /path/to/originalfile.txt
   ```
   - **Explanation:**
     - `touch` creates an empty file named `originalfile.txt` if it doesn’t already exist.

2. **Create the Hard Link:**
   - Create a hard link pointing to the original file:
   ```bash
   ln /path/to/originalfile.txt /path/to/hardlink.txt
   ```
   - **Explanation:**
     - This command creates a hard link at `/path/to/hardlink.txt` that points to the same data blocks as `/path/to/originalfile.txt`.

3. **Test the Hard Link by Deleting the Original File:**
   - Delete the original file:
   ```bash
   rm /path/to/originalfile.txt
   ```
   - **Outcome:**
     - The hard link remains fully functional because it still points to the same data blocks. The content of the file is preserved, and the hard link can be used as though it were the original file.

### **Understanding iNodes in the Filesystem**
- An iNode is a data structure used by a filesystem to store information about a file or directory, excluding the actual data.
- **Key Information Stored in an iNode:**
    - File type (regular file, directory, symbolic link, etc.)
    - File size
    - Number of hard links
    - User ID (owner of the file)
    - Group ID (associated group)
    - Access permissions (read, write, execute)
    - Timestamps (last accessed, last modified, etc.)
    - Pointers to data blocks on the disk

- **Importance of iNodes:**
    - iNodes are critical for the filesystem’s ability to manage files. Each file or directory has an associated iNode, and the filesystem uses iNodes to track and retrieve the data.
    - **Limited Resource:** Every filesystem has a finite number of iNodes. This means that even if there’s free disk space, you cannot create new files or directories if all iNodes are exhausted.

  - **Command to Check iNode Usage:**
    ```bash
    df -i
    ```
    - `df -i` shows the number of iNodes available, used, and free within a filesystem. Monitoring iNode usage is important in environments where many small files are created.

* **Real-Life Example:**
    * **Scenario:** Consider a server with 100 GB of free space. A poorly designed program generates a massive number of small temporary files, each only a few bytes in size.
    * **Problem:** Despite the large amount of free disk space, the server encounters an error: "No space left on device." This occurs because the program has used up all available iNodes, even though the actual data stored is minimal.
    * **Solution:** The system administrator must identify and delete unnecessary files to free up iNodes, thus allowing the creation of new files.

---

## **Processes in Linux: Understanding and Managing**

### **Understanding Processes and Threads**

- **What is a Process?**
  - A process is an instance of a program in execution. When you run a program, the operating system creates a process to manage its execution. This process includes the program’s code, data, and resources like memory and CPU time.
  - **Components of a Process:**
    - **Code Segment:** The executable instructions of the program.
    - **Data Segment:** Variables, arrays, and dynamically allocated memory.
    - **System Resources:** Handles to files, network connections, and other system resources required for execution.
    - **Process Control Block (PCB):** Contains information about the process’s state, priority, registers, and pointers to its memory location.

- **Analogy to Understand Processes:**
  - Imagine a car factory where different assembly lines (processes) work simultaneously to build different parts of a car. Each assembly line is independent but may share resources (like tools or parts). The Factory Manager (operating system) oversees the operation, ensuring that each line has the necessary resources and is working efficiently.

  - **Demo on a Linux System:**
    - Use commands like `ps -ef` and `ps -aux` to display active processes on a Linux system.
    - **Explanation of Output Parameters:**
      - **PID (Process ID):** Unique identifier for each process.
      - **TTY (Terminal Type):** Indicates the terminal associated with the process.
      - **STAT (Process State):** Shows the current state of the process (e.g., running, sleeping).
      - **%CPU:** Percentage of CPU time used by the process.
      - **%MEM:** Percentage of memory used by the process.

### **Types of Processes**

1. **Interactive Process**
   - **Definition:** Processes that require direct interaction with the user.
   - **Example:** When you type a command like `ls` in the terminal, an interactive process is created to execute that command and display the output.
   - **Characteristics:**
     - These processes are typically short-lived and return control to the user quickly after execution.
     - Interactive processes are often initiated by commands entered in a shell or GUI application.

2. **Batch Process**
   - **Definition:** Processes that do not require user interaction and are often executed as scheduled tasks.
   - **Example:** A script that runs every night to back up data on a server.
   - **Characteristics:**
     - Batch processes are usually long-running tasks that execute at specified times, often during off-peak hours to optimize system efficiency.
     - They are typically managed by job scheduling systems like `cron` or `at`.

3. **Daemon Process**
   - **Definition:** Background processes that run continuously, often providing system services.
   - **Example:** A web server like Apache runs as a daemon process, handling incoming web requests without direct user interaction.
   - **Characteristics:**
     - Daemon processes start at system boot and continue running in the background, usually marked by a question mark (`?`) in the TTY column of the `ps` command output.
     - They are essential for the ongoing operation of many system services, such as logging, network management, and scheduled tasks.

4. **Real-Time Process**
   - **Definition:** Processes that must complete their execution within a strict time frame.
   - **Example:** Processes controlling a pacemaker or air traffic control system must operate within precise time constraints to avoid failure.
   - **Characteristics:**
     - Real-time processes are prioritized by the system to ensure they receive the CPU time they need to complete on time.
     - These processes are critical in systems where delays could result in catastrophic outcomes.

### **Process States**

1. **Running [R]**
   - **Definition:** The process is actively being executed by the CPU.
   - **Characteristics:**
     - Only one process per CPU core can be in the running state at any given moment.
     - **Example:** The command `ps -AUX` itself is a running process while it gathers and displays information about other processes.

2. **Sleeping**
   - **Definition:** The process is not currently using the CPU but is waiting for an event, such as user input or the completion of an I/O operation.
   - **Types:**
     - **Interruptible Sleep [S]:** The process can be interrupted by signals or user input. For example, a process waiting for data input from a user is in interruptible sleep.
     - **Uninterruptible Sleep [D]:** The process is waiting for a critical event, such as disk I/O, and cannot be interrupted. This state is often associated with processes waiting for hardware-related events.

3. **Idle**
   - **Definition:** The process is not using any CPU or memory resources but is in a state of readiness, waiting for specific conditions to be met before execution resumes.
   - **Characteristics:**
     - Idle processes consume minimal system resources and typically wait for hardware availability or specific triggers to become active.

4. **Stopped [T]**
   - **Definition:** The process has been paused or halted, usually by a user intervention like pressing `Ctrl+Z`.
   - **Characteristics:**
     - A stopped process can be resumed later with commands like `fg` (foreground) or `bg` (background).

5. **Zombie [Z]**
   - **Definition:** The process has completed execution, but its entry remains in the process table because the parent process has not acknowledged its termination.
   - **Characteristics:**
     - Zombies do not consume CPU resources but occupy space in the process table, which could lead to system instability if too many zombie processes accumulate.
     - **Example:** A child process finishes execution, but the parent process fails to call `wait()`, leaving the child process in a zombie state.
