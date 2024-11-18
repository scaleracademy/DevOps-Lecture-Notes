# Typed Notes on Concurrency and Beyond

---

## Threads

### Introduction to Threads
- A **thread** is the smallest unit of execution within a process.
  - Unlike processes, which are independent units of execution, threads exist within a process and execute instructions sequentially.
  - A single process can contain multiple threads, which are lightweight and share resources with each other.
  - These shared resources include memory, open files, and other attributes of the process.

### Features of Threads
- Threads are beneficial because they allow parallelism and concurrency within a single process.
- Threads share:
  - **Memory space**: All threads in the same process share the same memory address space.
  - **Resources**: Threads within a process share resources like open files and network connections.
  - **Data**: They can communicate with each other through shared data, which allows efficient inter-thread communication without the need for inter-process communication (IPC) mechanisms.

### Comparison of Processes and Threads

| Feature                 | Process                                                   | Thread                                         |
|-------------------------|-----------------------------------------------------------|------------------------------------------------|
| **Definition**           | An independent instance of a program running on the system. | A smaller unit of execution within a process.  |
| **Memory Space**         | Each process has its own separate memory space.            | Threads within the same process share memory.  |
| **Creation Time**        | Processes require more time and resources to create.       | Threads are lightweight and can be created quickly. |

### Real-Life Implications
- When managing **large-scale infrastructure**, the concepts of processes and threads are critical for efficiency and performance.
  - For example, **infrastructure provisioning** often uses multi-threading to handle concurrent tasks, speeding up deployment.
  - In **CI/CD pipelines**, tasks like testing, building, and deploying can be run concurrently in different threads or processes.
  - **Linux scripting** allows you to use threads for parallel tasks like file system monitoring, where different threads handle different events simultaneously.
  
**Ask Students:**  
- What are some real-life implications of using threads vs. processes?
  
---

## Concurrency and Parallelism

### Concurrency
- **Concurrency** refers to a system's ability to handle multiple tasks or processes at the same time.
  - Concurrency does not necessarily mean the tasks are running simultaneously but rather that they are in progress during overlapping time periods.
  - **Example Analogy:** A chef multitasking in the kitchen.
    - With one hand, the chef is boiling pasta, and with the other, they are chopping vegetables. Both tasks are progressing concurrently, although they may not be performed exactly at the same time.
  
### Parallelism
- **Parallelism** takes concurrency a step further by executing tasks truly at the same time, often on different CPU cores or processors.
  - Parallelism is about dividing work into smaller, independent tasks and running them simultaneously for faster completion.
  - **Example Analogy:** Multiple chefs working in a kitchen.
    - One chef boils pasta while another chops vegetables, both actions occurring at the same time but performed by different chefs.

### Combining Concurrency and Parallelism
- Concurrency and parallelism are not mutually exclusive; they often work together to optimize performance.
  - **Concurrency** allows tasks to make progress simultaneously.
  - **Parallelism** improves performance by running these tasks at the same time.
  
  - **Illustration:**
    ![Concurrency and Parallelism](https://hackmd.io/_uploads/BkYvuHDnC.png)

### Use Cases

1. **Input/Output (I/O) Bound Tasks**
   - I/O bound tasks are tasks that spend most of their time waiting for I/O operations (e.g., reading from disk, network operations).
   - The time taken to receive a response creates natural pauses in task execution.
   - **Optimal Approach:** Use **concurrency** for I/O bound tasks to take advantage of waiting periods and allow other tasks to proceed in the meantime.
   - **Example:** Sending a request to a remote server, such as sending a message to the moon. Since it takes a long time to get a response, the system can perform other tasks during the waiting period.

2. **CPU Bound Tasks**
   - CPU bound tasks are those that require significant processing power, such as performing calculations or executing algorithms.
   - **Optimal Approach:** Use **parallelism** to split the task into smaller parts and distribute them across multiple CPU cores. Each core handles a portion of the task, speeding up overall execution.
   - **Example:** A large mathematical computation divided into smaller problems and processed across multiple CPU cores.

> **Note:** More CPU cores result in more concurrency and parallelism.
  - A 4-core CPU can handle more processes and threads than a single-core CPU. Similarly, an 8-core CPU doubles the concurrency potential of a 4-core CPU.

### CI/CD Pipeline Example
- **CI/CD pipelines** (Continuous Integration/Continuous Deployment) are practical examples of how concurrency and parallelism are used.
  - Tasks in a CI/CD pipeline include testing, building, and deploying code, all of which benefit from parallel and concurrent execution.

1. **Sequential Execution**  
   - Tasks are executed one after the other.
     - Task 1 → Task 2 → Task 3 → Task 4 → Task 5.
     - This is simple but can be slow, especially if one task takes a long time.

2. **Concurrent and Parallel Execution**  
   - **Parallelism** allows multiple tasks to run simultaneously.  
     - Example: Task 1, Task 2, and Task 3 run at the same time.
   - **Concurrency** allows new tasks to start as soon as other tasks complete.
     - Example: After Task 1 finishes, Task 4 starts, and after Task 2 finishes, Task 5 starts.
     - This results in faster overall pipeline execution.

---

## Synchronization Primitives

### Introduction to Synchronization Primitives
- **Synchronization primitives** are tools and mechanisms used to manage the access of multiple threads to shared resources. 
- They ensure that threads do not interfere with each other when accessing or modifying shared data.
- **Analogy:** Think of a playground where children take turns on the swing or slide. Rules are necessary to ensure that no child gets hurt or monopolizes the equipment.

### Types of Synchronization Primitives

1. **Mutex (Mutual Exclusion Lock)**  
   - A **mutex** ensures that only one thread can access a shared resource at a time.
   - **Example Analogy:** A slide in a playground where only one child can use it at a time. If another child tries to use it, they must wait.
   - In programming terms, if one thread is using a resource (like a shared variable), other threads attempting to use the same resource will be blocked until the first thread releases it.
   - **Real-Life Example:** At home, if the bathroom is occupied, you must wait until it’s free before using it.

2. **Spin Lock**  
   - A **spin lock** is similar to a mutex but operates slightly differently. Instead of putting a thread to sleep while waiting for the resource, the thread continuously checks (or spins) to see if the resource becomes available.
   - **Example Analogy:** Waiting outside a public bathroom and constantly checking if it's available instead of stepping away and waiting for a signal.
   - Spin locks are useful when the wait time is expected to be short, but they consume more CPU resources because the thread is actively checking the lock.
   - **Use Case:** Spin locks are used when context switching is easy and the overhead of waiting is greater than the cost of spinning.

3. **Semaphore**  
   - A **semaphore** is a signaling mechanism that controls access to a resource with a limited number of instances.
   - **Example Analogy:** Time slots in a playground where different groups of children can use the swings during designated times.
   - In programming, a semaphore allows multiple threads to access a limited number of identical resources, such as limited instances of a server or a database connection pool.

---

## Major Issues in Concurrency and Parallelism

1. **Race Condition**
   - A **race condition** occurs when two or more threads attempt to access shared data at the same time, leading to inconsistent or unexpected results.
   - **Example:** Two people in a kitchen both trying to use the last egg at the same time for different recipes.
   - **Cause:** Parallelism where multiple threads/processes access shared data simultaneously.
   - **Solution:** Use synchronization primitives (like **mutex**) to ensure that only one thread can access the shared resource at a time.

2. **Deadlock**
   - A **deadlock** occurs when two or more processes are stuck waiting for each other to release resources, causing a standstill.
   - **Example:** Cars at a four-way intersection where all drivers wait for the others to move, leading to gridlock.
   - **Solution:** Detect the deadlock and take corrective actions to resolve the situation, such as breaking the cycle or reassigning resources.

3. **Livelock**
   - **Livelock** is similar to deadlock but occurs when processes or threads are not blocked; instead, they keep changing their states in response to each other but make no progress.
   - **Example:** Two backup servers both trying to become the primary server, backing off when they detect the other server's attempts, leading to no resolution.
   - **Solution:** Implement techniques like **random backoff** or prioritizing processes to avoid constant switching.

4. **Starvation**
   - **Starvation** occurs when a process or thread waits indefinitely because other processes are continuously prioritized.
   - **Example:** A person waiting in a regular queue at a temple while others use a VIP queue, causing the person to never progress.
   - **Solution:** Implement **aging**, where the priority of a waiting process increases over time, ensuring that it eventually gets processed.

---

## Practical Demonstration: Bash RC File

### Bash RC File Overview
- The `.bashrc` file is a hidden configuration file in the user's home directory.
  - This file is loaded whenever a new terminal session starts in interactive mode.
  - It allows users to set up custom configurations, define environment variables, and create aliases for commonly used commands.

### Editing the `.bashrc` File
1. Navigate to the home directory using:
   ```bash
   cd ~
   pwd
   vi ~/.bashrc

2. Modify the terminal prompt by adding configurations such as `\u` for the username and `\w` for the current working directory. For example:
   ```bash
   PS1="\u \w\$ "
   ```

3. Apply the changes in the current terminal session by running:
   ```bash
   source ~/.bashrc
   ```

### Creating Aliases
- **Aliases** allow users to define shortcuts for longer commands. For example:
   ```bash
   alias pp='pwd'
   ```

- This alias creates a shortcut for the `pwd` command, allowing you to type `pp` instead of the full command.
- To make aliases persistent across terminal sessions, add them to the `.bashrc` file.
