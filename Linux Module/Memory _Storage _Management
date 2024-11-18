# Typed Notes on Memory & Storage Management

---

## Understanding Memory Management

### **Overview**
- In the previous class, we explored how the OS manages processes through scheduling. Today, we'll discuss how the OS efficiently allocates memory to processes.  
- **Analogy**: Just like organizing books on a shelf, the OS must allocate memory to different programs so they can run smoothly. Without proper organization, processes may slow down or crash due to insufficient memory.
  
### **Key Topics Covered**:
1. **Memory Allocation**:
   - How the OS ensures memory is distributed among various running programs.
2. **Memory Mapping**:
   - The process of mapping logical addresses used by a program to physical addresses in memory.
3. **Virtual Memory**:
   - A method that enables a system to use more memory than physically available by utilizing disk space.
4. **Garbage Collection**:
   - Automated recovery of unused memory to prevent wastage.
5. **Challenges in Memory Management**:
   - **Swapping**: Moving processes in and out of memory to free space for active tasks.
   - **Fragmentation**: Memory gaps caused by processes using and releasing memory inefficiently.
6. **Strategies for Efficient Memory Management**:
   - **Paging**: Dividing memory into fixed-size blocks.
   - **Segmentation**: Dividing memory into variable-sized blocks based on program structure.

---

### **Types of Memory**

1. **Primary Memory (RAM)**:
   - RAM stores data for programs that the CPU needs to access quickly.
   - **Characteristics**:
     - Fast but temporary (data is lost after a reboot).
     - Smaller in size compared to secondary memory.
   - **Analogy**: Like a temporary workspace where you store things while you're working on them. After a reboot, this workspace is cleared.

2. **Secondary Memory**:
   - Used for long-term data storage and persists after a reboot.
   - **Characteristics**:
     - Larger than RAM, but slower to access.
     - Hard disks, SSDs, and external drives fall into this category.

3. **Cache Memory**:
   - Cache memory stores copies of frequently accessed data from primary memory to speed up processing.
   - **Characteristics**:
     - Smaller, more expensive, and volatile (data is lost after power off).
     - **Analogy**: Think of cache as sticky notes placed on your desk for quick access to important information.

4. **Virtual Memory**:
   - Virtual memory is a technique that allows the system to compensate for physical memory shortages by temporarily transferring data from RAM to disk space.
   - **Mechanism**:
     - When RAM is full, the system swaps inactive data to virtual memory on the hard drive, allowing more processes to run.
     - **Example**: Like moving less-used books to a basement when your bookshelf is full, so you have room for the ones you're actively reading.

---

## Efficient Memory Management

### **Paging**
- **Concept**: Paging divides memory into fixed-size blocks known as **pages** (logical memory) and **frames** (physical memory). Each process is divided into pages, and the OS maps these pages to frames.
  - **Analogy**: Think of a book divided into pages. Each page has the same size regardless of the content. Similarly, in memory, each page occupies the same amount of space, even if it contains different amounts of data.
  - **Advantages**:
    - Simple memory allocation.
    - Efficient handling of memory fragmentation.

### **Segmentation**
- **Concept**: Unlike paging, segmentation divides memory into **variable-sized** blocks called segments. Each segment corresponds to a logical part of a program, such as code, data, or the stack.
  - **Analogy**: Segmentation is like dividing a book into chapters, where each chapter is of different length but represents a cohesive part of the story.
  - **Example**:
    - **Code Segment**: Contains the program’s executable code.
    - **Data Segment**: Contains program variables and data.
    - **Stack Segment**: Stores temporary data like function calls and local variables.

---

### **Virtual Memory**
- **Why Do We Need Virtual Memory?**
  - Virtual memory expands the system's memory capabilities by using disk space when physical memory (RAM) is exhausted.
  - **Benefits**:
    - Enables multitasking by allowing more processes to run simultaneously.
    - Cost-efficient because it avoids the need to increase the size of RAM, which is expensive.

- **Challenges with Virtual Memory**:
  1. **Disk Thrashing**:
     - Occurs when the system spends more time moving data between RAM and virtual memory than executing tasks. This results in a significant performance drop.
     - **Example**: Storing frequently used items in the basement and retrieving them every time you need them wastes a lot of time.
  
  2. **Memory Overcommitment**:
     - Happens when more memory is allocated than is physically available, forcing the system to rely heavily on virtual memory.
     - **Example**: Trying to store 30 books in a drawer that can only hold 10, with the excess books kept elsewhere.

---

### **Garbage Collection**
- **Purpose**: Garbage collection is the process of reclaiming memory that is no longer in use by a program, ensuring efficient use of available memory.
  - **Mechanism**: The OS automatically identifies memory that is no longer needed and reclaims it.
  - **Analogy**: Like a waste collector who regularly removes garbage, freeing up space for new items.

- **Garbage Collection in Java**:
  - **Command**: Use `jstat -gc <PID> 1000` to monitor garbage collection for a Java process.
  - **Explanation**:
    - This command checks garbage collection statistics every 1000 milliseconds, helping developers ensure memory is managed efficiently.

- **Practical Example**:
  - Command: `ps -aux | grep "script" | awk 'print $2' | xargs jstat -gc 1000`
  - **Explanation**:
    - `ps -aux`: Lists running processes.
    - `grep "script"`: Filters processes by name.
    - `awk 'print $2'`: Extracts the process ID (PID).
    - `xargs`: Passes the PID to `jstat -gc` to display garbage collection statistics.

---

## Memory Allocation Techniques

1. **Static Memory Allocation**:
   - **Overview**: Memory is allocated during compile time, and the size is fixed throughout the program's execution.
   - **Drawback**: Any unused memory in this allocation is wasted.
   - **Example**: Programs with critical memory requirements, where allocation must remain constant.

2. **Dynamic Memory Allocation**:
   - **Overview**: Memory is allocated at runtime, allowing flexibility based on the program's current needs.
   - **Advantage**: Reduces memory wastage since memory is only allocated when necessary.

### **Memory Allocation Strategies**:
1. **Stack Allocation (Static)**:
   - **Usage**: Memory is allocated when a function is called and deallocated when the function exits.
   - **Example**: Local variables in a function.

2. **Heap Allocation (Dynamic)**:
   - **Usage**: Memory is allocated from a memory pool at runtime, offering flexibility for complex programs with varying resource requirements.
   - **Example**: Programs that dynamically create and destroy objects, such as in object-oriented programming.

---

## Practical Demonstration of Memory Commands

### **Free Command**:
- **Command**: `free -h`
- **Usage**: Displays the total, used, free, shared, cache, and swap memory on the system.
- **Explanation**: 
  - `-h` flag provides output in a human-readable format (MB/GB).

### **Top Command**:
- **Command**: `top`
- **Usage**: Provides real-time memory usage, including CPU, memory, and swap statistics.

### **Proc File System**:
- **File**: `/proc/meminfo`
- **Usage**: Displays detailed information about the system's memory usage, including cache and swap statistics.

### **VMSTAT Command**:
- **Command**: `vmstat 1`
- **Usage**: Provides system statistics (e.g., memory, CPU, process information) updated every second.
- **Important Parameters**:
  - **R**: Number of processes waiting for runtime.
  - **B**: Number of blocked processes.
  - **SWPD**: Amount of swap memory in use.
  - **SI**: Memory swapped from disk to RAM.
  - **SO**: Memory swapped from RAM to disk.
  - High **SI** and **SO** values may indicate **disk thrashing**, where the system spends excessive time swapping data between RAM and disk.

---

## Swap Memory

### **What is Swap Memory?**
- **Swap Memory**: An area on a storage device (SSD or hard disk) used by the OS when physical RAM is full. Swap memory works in conjunction with RAM to create **virtual memory**, allowing more processes to run simultaneously.

### **Practical Demonstration: Managing Swap Space**

1. **Check Existing Swap Space**:
   - **Command**: `sudo swapon --show`
   - **Explanation**: Displays details of active swap space. If none exists, it returns nothing.

2. **Create a Swap File**:
   - **Command**: `sudo fallocate -l 1G /swapfile`
   - **Explanation**: Allocates 1GB of space for swap in the root directory.

3. **Secure the Swap File**:
   - **Command**:

 `sudo chmod 600 /swapfile`
   - **Explanation**: Changes permissions to restrict file access, securing it for root use only.

4. **Enable Swap on the File**:
   - **Command**: `sudo mkswap /swapfile`
   - **Explanation**: Marks the file as usable swap space.

5. **Activate the Swap File**:
   - **Command**: `sudo swapon /swapfile`
   - **Explanation**: Enables the swap file for immediate use.

6. **Verify Swap Space**:
   - **Command**: `sudo swapon --show`
   - **Explanation**: Displays the current swap space in use.

### **Issues with Swap Memory**:
- **Overcommitment**: 
  - Swap space should ideally be equal to or smaller than the system’s RAM. Overcommitting (i.e., allocating too much swap space) can lead to **disk thrashing**, where the system spends excessive time moving data between RAM and swap.

### **Making Swap Space Permanent**:
- Swap memory will be disabled after a reboot unless explicitly set to be permanent.
- **Command**: `vi /etc/fstab`
- Add the following line to `/etc/fstab`:
  ```bash
  /swapfile swap swap defaults 0 0
  ```
  - **Explanation**:
    - `/swapfile`: The file being used as swap.
    - `swap`: File system type.
    - `defaults`: Default mount options.
    - `0 0`: Prevents file system dump and checking at boot.

---

## Storage Management

Storage management involves organizing and maintaining different types of storage devices to ensure efficient use and data integrity.

### **Historical Storage Devices**:
- **Magnetic Tapes**: Used for data backups.
- **Floppy Disks**: Portable storage with limited capacity.
- **CDs/DVDs**: Optical storage for multimedia and software distribution.
- **Hard Disks (HDD)**: Magnetic disks offering large storage capacity.

### **Modern Storage**:
- **Solid State Drives (SSD)**: Faster, more reliable storage than HDDs due to the lack of moving parts.
- **Cloud Storage**: Remote storage solutions such as Dropbox and Google Drive that allow users to store and access data over the internet.

### **Types of Storage**:

1. **Direct Access Storage**:
   - Examples include **USB drives**, **HDDs**, and **SSDs**, allowing direct access to data stored locally.

2. **Network Storage**:
   - Storage devices accessible over a network, often used by organizations to provide centralized data storage for multiple users. Examples include **Network Attached Storage (NAS)** and **Storage Area Networks (SANs)**.

3. **Cloud Storage**:
   - Provides remote storage solutions where data is stored offsite and can be accessed via the internet. Used by companies for large-scale storage, as seen in data centers.

### **RAID (Redundant Array of Independent Disks)**:
- RAID is a method of combining multiple physical disks into a single logical unit to improve performance and provide redundancy. RAID arrays ensure data is still accessible even if a disk fails.
  - **RAID Levels**: 0 (striping), 1 (mirroring), 5 (striping with parity), and others, offering various balances between performance and fault tolerance.

### **Logical Volume Management (LVM)**:
- **Concept**: LVM aggregates multiple physical volumes (disks) into a **Volume Group (VG)**, which can then be divided into **Logical Volumes (LV)**.
- **Example**:
  - You have three 10GB physical volumes, which are combined into a 30GB volume group. From this, you can create two 15GB logical volumes.

- **Commands**:
  - **`lsblk`**: Lists all block devices.
  - **`sudo pvcreate /dev/sdX`**: Initializes a disk or partition as a physical volume.
  - **`sudo vgcreate VGname /dev/sdX`**: Creates a volume group.
  - **`sudo lvcreate -L SizeG -n LVname VGname`**: Creates a logical volume.
  - **`sudo mount /dev/VGname/LVname /mount-point`**: Mounts a logical volume to a directory.
  - **`sudo lvextend -L +SizeG /dev/VGname/LVname`**: Extends the size of a logical volume.
  - **`sudo lvreduce -L SizeG /dev/VGname/LVname`**: Reduces the size of a logical volume.
