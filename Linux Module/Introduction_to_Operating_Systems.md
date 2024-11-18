# Introduction to Operating Systems

## What is an Operating System?
An **Operating System (OS)** is a critical software component that acts as an interface between the user and the computer hardware. The OS enables users to perform tasks without needing to interact directly with the hardware in machine code. Essentially, it translates human commands into machine-readable language, making the interaction with the computer more intuitive and user-friendly.

### Key Functions of an Operating System
1. **Memory Management**: The OS is responsible for allocating and managing the system's memory resources, which include RAM, among various running processes.
2. **Process Management**: The OS manages processes, which are units of work. Each process requires specific resources that the OS allocates and monitors.
3. **Storage Management**: This involves managing how data is stored on physical drives (like C: or D: in Windows) and handling both internal and external storage devices.
4. **I/O Management**: The OS manages input and output operations, ensuring that data is correctly transferred between the hardware and software.
5. **Security Management**: The OS provides basic security features to protect the system from unauthorized access, like user authentication and permissions.

### Why Can’t We Interact Directly with Binary?
Interacting directly with binary (machine code) is possible but highly complex and impractical for users. The OS simplifies this process by translating machine language into human-readable formats, allowing users to interact with the computer more efficiently.

---

# Basic Functions of an Operating System

## Memory Management
Memory management in an OS is akin to a factory manager distributing tasks among workers. The OS ensures that each running process receives an appropriate portion of the system's memory, typically referring to RAM, to function efficiently. Proper memory allocation is crucial for maintaining overall system performance and preventing any one process from monopolizing resources.

## Process Management
Processes are fundamental units within the OS, representing individual tasks that the system executes. A single task can consist of multiple processes, each requiring distinct resources. The OS manages these processes, ensuring they receive the necessary resources. For example, commands like `ps` and `top` in Linux can display the resources allocated to different processes.

## Storage Management
The OS is responsible for managing how data is stored on and retrieved from physical storage devices like hard drives and SSDs. Unlike memory (RAM), which is temporary and volatile, storage refers to permanent data repositories on devices such as the C: or D: drives in Windows systems.

## Security Management
Every OS has built-in security mechanisms to protect the system from unauthorized access and potential threats. These include features like user authentication, file permissions, and firewall settings. For instance, Windows provides a range of security settings that help safeguard the system.

---

# Understanding Linux

## Why Prefer Linux?
Linux is a highly favored operating system for several reasons:

- **Open Source**: Linux's open-source nature allows users to view, modify, and distribute the source code, enabling custom modifications and improvements.
- **Flexibility**: Linux offers extensive customization options, allowing users to tailor the OS to their specific needs.
- **Security**: Linux allows users to manage and customize their security settings. For example, during the CloudStrike incident, only Windows systems were impacted, while Linux remained unaffected.
- **Multi-User Support**: Unlike Windows, which has limitations due to licensing, Linux supports multiple users simultaneously. Each user can have their own directories, permissions, and unique environment, making it ideal for systems with multiple users.
- **Career Opportunities**: Mastery of Linux opens up numerous career opportunities in fields like system administration, cybersecurity, and software development.

## The Kernel
The **Kernel** is the core component of Linux, directly interacting with the hardware. It functions as a middleman between the hardware and software applications, managing resources such as memory and CPU time. An analogy would be a manager in a company who communicates with higher authorities about resource allocations. Similarly, the Kernel ensures that hardware resources are efficiently managed and that applications receive the necessary resources.

## Linux Boot Process
The Linux boot process is a sequence of steps that the system undergoes from powering on to becoming operational:

1. **BIOS (Basic Input/Output System)**: This initial check verifies hardware functionality and starts the boot process. In modern systems, UEFI replaces BIOS, providing more advanced features.
2. **GRUB (Grand Unified Bootloader)**: GRUB presents a menu to choose the OS version or boot options. If there's an issue, the system may enter the GRUB console, where troubleshooting begins.
3. **Kernel**: Once the bootloader passes control, the Kernel is loaded into memory and begins managing hardware. It is the core component of the OS, handling tasks like memory allocation and process management.
4. **System Services (systemd)**: Systemd is a service manager in Linux, handling the initiation and management of various system tasks, similar to how a sous chef assists the head chef.
5. **Run Levels**: In older Linux systems, run levels determined the operating mode, such as a text-only interface (Run Level 3) or a graphical user interface (Run Level 5).

### systemctl
The `systemctl` command is used to control systemd and manage system services. For example, `systemctl start nginx` starts the Nginx web server by interacting with systemd.

---

# Linux Directory Structure

## Important Directories in Linux
- **Root ("/")**: The root directory is the base of the Linux file system, containing all other directories.
- **Home ("/home")**: Each user has a personal space within the `/home` directory, where user-specific files and settings are stored.
- **Bin and Sbin ("/bin" and "/sbin")**: These directories contain essential binaries (executable files), with `/sbin` specifically housing system binaries.
- **ETC ("/etc")**: This directory is the heart of system configuration, containing scripts and settings that control the behavior of the Linux system.
- **Dev ("/dev")**: `/dev` is a special directory that represents devices as files, crucial for device management.
- **Temp ("/tmp")**: This directory is used for temporary file storage, where files can be safely deleted after use.

---

# Practical of Linux Commands

## Using Linux Commands

1. **pwd** (Present Working Directory): Displays the current directory.
    ```bash
    pwd
    ```

2. **ls**: Lists all files and directories in the current directory.
    - Use `ls -a` to include hidden files (those starting with a dot).
    ```bash
    ls
    ls -a
    ```

3. **cd** (Change Directory): Navigates to different directories.
    - `cd ..` moves up one directory level.
    - You can use full paths to move directly to a specific directory.
    ```bash
    cd
    cd ..
    ```

4. **mkdir**: Creates a new directory.
    - Example: `mkdir test` creates a directory named `test`.
    - Use `mkdir -p` to create nested directories in one command.
    ```bash
    mkdir test
    mkdir -p test/test1/test2
    ```

5. **man**: Accesses the manual for a specific command.
    - Example: `man ls` opens the manual for the `ls` command, detailing options like `ls -d` to list directories only.
    ```bash
    man ls
    ```

6. **cd /**: Takes you to the root directory, which contains several important directories such as `/bin`, `/lib`, `/tmp`, and `/etc`.
    ```bash
    cd /
    ```

7. **/tmp Directory**: Stores temporary files, which can be deleted without significant impact unless they are in use.

## Advanced Directories
- **/media**: Used for mounting removable devices, akin to USB devices in Windows.
- **/mount**: Displays attached portable or mount devices.
- **/opt**: Traditionally used for third-party software installations.

## System Interaction
It’s crucial not to modify critical directories as doing so can affect the entire system. For instance, deleting essential files can prevent interaction with system commands like `systemctl`.

---
