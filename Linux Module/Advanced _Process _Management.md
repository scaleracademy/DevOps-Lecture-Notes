# Typed Notes on Advanced Process Management

---

## Introduction to Process Management

### **How the OS Manages Processes**

The Operating System (OS) is responsible for ensuring that all processes running on a computer system are managed effectively. A process is essentially a program in execution, which requires the OS to allocate resources such as CPU time, memory, and input/output (I/O) devices. To ensure that multiple processes can run smoothly without conflicts or delays, the OS employs **scheduling mechanisms**.

### **Process Scheduling**

Process scheduling is how the OS organizes and prioritizes processes to make the most efficient use of the CPU. There are two primary types of scheduling methods:

1. **Preemptive Scheduling**:
   - In preemptive scheduling, the OS has the authority to interrupt or pause a currently running process if a higher-priority task needs to be executed. This ensures that urgent processes are not delayed, improving the system's responsiveness.
   - **Example**: Imagine you are watching a movie, and suddenly, your father calls. Since the call is more urgent, you stop the movie to take the call.
   - **Common Algorithms**: One example of preemptive scheduling is the **Round-Robin** algorithm, which ensures that each process gets a fixed time slot for execution.

2. **Non-Preemptive Scheduling**:
   - In non-preemptive scheduling, once a process starts executing, the OS allows it to complete before starting any other process, even if a higher-priority task arrives during execution. This method is simpler but can lead to inefficiencies if high-priority tasks have to wait.
   - **Example**: If you're watching a movie and receive a call from a credit card company, you might choose to ignore the call and finish the movie, as the call isn't urgent.
   - **Common Algorithms**: **First Come First Serve (FCFS)** is a typical non-preemptive scheduling method where processes are handled in the order they arrive.

---

## Scheduling Algorithms

Scheduling algorithms are the core mechanisms by which the OS decides which process should run at any given time. Different algorithms prioritize processes based on various factors such as arrival time, task length, or process priority. Below are some of the key scheduling algorithms:

### **First Come First Serve (FCFS)**

- **Overview**:
    - In FCFS, processes are executed in the order they arrive, without considering their size, complexity, or resource demands. This straightforward method is easy to implement but may result in longer processes causing delays for shorter ones.
  
- **Explanation**:
    - Each process enters a queue. The OS selects the process at the front of the queue, executes it until completion, and then moves on to the next process.
  
- **Real-World Example**:
    - Think of standing in line at McDonald's. The first person to arrive gets served first, regardless of how simple or complex their order is. If someone orders just a coffee, they will still have to wait for the first customer to finish, even if that customer has a large, complex order.

### **Shortest Job First (SJF)**

- **Overview**:
    - The SJF algorithm selects the process with the shortest estimated execution time to run next, reducing the overall waiting time for short processes. This algorithm works well in environments where short tasks are more frequent than long tasks.

- **Explanation**:
    - In a queue of processes, the OS checks the estimated time required for each process to complete and selects the one with the shortest time. This helps to maximize efficiency by ensuring that small tasks don’t get delayed by longer processes.

- **Real-World Example**:
    - Imagine you're working on various tasks. If you have several short tasks (like replying to an email or picking something up from the floor), you complete them first before starting on larger tasks like writing a report. This reduces your overall workload quickly by getting the small things out of the way.
  
- **Advantages**:
    - This method significantly reduces waiting time when most tasks are short. For example, if you have 100 processes, where 98 are short and 2 are long, completing the shorter ones first helps minimize overall waiting time, allowing more processes to finish within a given time frame.

### **Priority Scheduling**

- **Overview**:
    - In priority scheduling, processes are assigned a priority, and the OS selects the process with the highest priority for execution. This method ensures that important tasks are handled before less critical ones.

- **Explanation**:
    - Every process is assigned a priority level. Higher-priority processes are executed before lower-priority ones, regardless of their arrival time.

- **Real-World Example**:
    - In a temple, a VIP guest is allowed to enter first and receive special treatment, even if other visitors have been waiting longer. Similarly, in a system, high-priority tasks are handled before others, even if they arrived later.

### **Round Robin (RR)**

- **Overview**:
    - The Round Robin algorithm is designed to provide fairness by allocating a fixed time slice (or quantum) to each process in the queue. After its time slice, the process is paused and the next one in line gets its turn.

- **Explanation**:
    - Each process is given an equal share of CPU time, ensuring no single process monopolizes the system. After completing its time slice, the process moves to the back of the queue if it still needs more CPU time.

- **Real-World Example**:
    - In a multiplayer game, each player gets an equal amount of time to play their turn. Once their time is up, the controller passes to the next player, ensuring everyone gets an equal chance to participate.

- **Advantages**:
    - This method is particularly useful in time-sharing systems where fairness and responsiveness are crucial. Round Robin ensures that no process can dominate the CPU, making it one of the most common scheduling algorithms.

### **Multi-Level Queue Scheduling**

- **Overview**:
    - In Multi-Level Queue Scheduling, processes are divided into multiple queues based on their characteristics (such as priority, type of task, etc.), and each queue has its own scheduling algorithm.

- **Explanation**:
    - Processes are categorized into different groups, such as system processes, user processes, interactive processes, etc. Each category is assigned its queue, and each queue can be managed by different scheduling algorithms. This ensures efficient handling of processes based on their type.

- **Real-World Example**:
    - Think of a hospital where patients are categorized into different queues: senior citizens, women, men, etc. Each queue has its own system for attending patients, ensuring fairness within the group while preventing interference from other categories.

---

## Throughput and CPU Utilization

As a system engineer or DevOps professional, two of the most important metrics to optimize for are **Throughput** and **CPU Utilization**. These two factors play a significant role in determining the overall performance and efficiency of the system.

### **CPU Utilization**

- **Definition**:
    - CPU Utilization measures how effectively the CPU is being used. It reflects the percentage of time the CPU spends working on processes, as opposed to being idle.

- **Explanation**:
    - A higher CPU utilization means the CPU is actively processing tasks and not wasting resources. However, it’s important to balance CPU utilization to avoid overloading the system, which could result in slower performance.

- **Real-World Example**:
    - Consider a student studying for 8 hours. If the student stays focused without distractions, they make the most of their study time. This is equivalent to maximizing CPU utilization.

### **Throughput**

- **Definition**:
    - Throughput refers to the number of processes or tasks completed in a given period. It is a measure of how much work the system accomplishes within a set time frame.

- **Explanation**:
    - High throughput is achieved when many processes are completed efficiently. Systems that need to handle many tasks simultaneously, such as web servers or cloud services, prioritize throughput to serve more users quickly.

- **Real-World Example**:
    - Imagine a student covering many different subjects in a day. The number of topics they finish is their throughput, representing how much they achieved during the study session.

### **Throughput vs CPU Utilization: Practical Examples**

#### **Instagram (Throughput Focused)**:
- **Scenario**: You have 100 processes, where 10 take 1 hour each, and 90 take 1 minute each.
- **Approach**: In a platform like Instagram, the focus would be on **throughput**—processing the 90 quick tasks first. This maximizes the number of users served in a short time.

#### **NASA Supercomputer (CPU Utilization Focused)**:
- **Scenario**: The same distribution of processes as Instagram—10 long processes and 90 short ones.
- **Approach**: For NASA's supercomputer, **CPU utilization** is critical. All processes, including the long ones, must be completed for final results. The goal is to maximize efficiency and ensure the CPU works on all necessary tasks without wasting time.

---

## Inter-Process Communication (IPC)

Inter-Process Communication (IPC) is a fundamental concept in process management. Processes often need to communicate with each other to synchronize tasks and efficiently manage resources. IPC mechanisms enable processes to exchange data, signals, and control information.

### **Why Processes Need to Communicate**

- Processes require communication to achieve **synchronization** and **efficient resource management**. Without proper communication, processes could end up working in isolation, which might lead to redundant work or resource conflicts.

### **Real-World Example**:
- In a car manufacturing assembly line, one

 team may be responsible for producing wheels, while another handles engines. To ensure that the production is balanced (e.g., 1000 wheels but only 10 engines would be wasteful), these teams need to communicate regularly. Similarly, in computing, processes must communicate to stay coordinated and avoid resource conflicts.

### **Methods of Inter-Process Communication**

#### 1. **Shared Memory**
- **Overview**:
    - In shared memory, processes allocate a portion of their memory that other processes can access, allowing them to exchange information efficiently.

- **Explanation**:
    - Shared memory acts like a **community whiteboard** where all processes can read and write data. However, since multiple processes can access the same memory region, mechanisms like semaphores or mutexes are required to prevent simultaneous access, which could lead to conflicts like **deadlocks** or **livelocks**.

- **Advantages**:
    - It is one of the fastest means of communication between processes since no message passing is involved.

- **Disadvantages**:
    - Shared memory comes with security risks because any process with access can potentially interfere with or read the data. Additionally, the need for synchronization mechanisms can add complexity to the communication.

#### 2. **Message Passing**
- **Overview**:
    - In message passing, processes communicate by sending and receiving messages, typically in the form of packets. This can occur between processes on the same machine or over a network.

- **Explanation**:
    - Message passing is safer than shared memory because each message is directed to a specific destination, reducing the risk of conflicts. However, it is slower since sending and receiving packets adds overhead.

- **Advantages**:
    - Simplicity and safety, as messages are explicitly sent and received by specific processes.

- **Disadvantages**:
    - The added overhead of sending packets and potential latency make it slower than shared memory.

#### 3. **Queue Management in Linux**

In Linux, queues facilitate IPC by allowing processes to send and receive messages or data in a structured manner. There are two main types of pipes used in Linux for IPC:

- **Unnamed Pipe**:
    - Unnamed pipes are created dynamically and allow for immediate data transfer between processes, but they don’t persist after the communication is complete.
    - **Example**: The command `cat abc.txt | grep "scalar"` sends the output of the `cat` command to `grep` through an unnamed pipe.

- **Named Pipe**:
    - Named pipes, created using the `mkfifo` command, are persistent and allow multiple processes to read and write data over time.
    - **Example**: A pipe created with `mkfifo pipe_name` enables one terminal to write data, and multiple terminals can read that data.

### **Practical Demonstration of IPC with Named Pipes**

Here’s how you can demonstrate inter-process communication using named pipes in Linux:

1. **Create a named pipe**:
    ```bash
    mkfifo pipe
    ```

2. **Write data to the pipe in one terminal**:
    ```bash
    echo "rat" > pipe
    ```

3. **Read the data from the pipe in another terminal**:
    ```bash
    less < pipe
    ```

This setup shows how data written to a pipe in one terminal can be read in another, demonstrating simple yet effective communication between processes.

---

## Socket Communication and UPI Case Study

### **Socket Communication**

A **socket** is one endpoint in a two-way communication link between two programs running on a network. Sockets allow these programs to exchange data across networks, and they support various protocols such as TCP (Transmission Control Protocol) and UDP (User Datagram Protocol).

### **Key Concepts of Sockets**:
- **End-to-End Communication**: 
    - A socket represents one side of a connection, and data flows between the two ends, enabling communication between systems or processes.
  
- **Support for Protocols**:
    - **TCP** (Connection-oriented): Ensures reliable data transfer.
    - **UDP** (Connectionless): Faster but less reliable data transmission.

- **Bi-Directional Communication**:
    - Data can flow in both directions, making sockets suitable for real-time communication applications.

### **Case Study: UPI (Unified Payments Interface)**

UPI is an example of a complex system where multiple services and components need to communicate seamlessly for a transaction to occur. Understanding how IPC mechanisms support UPI transactions offers valuable insights into real-world applications of these concepts.

#### 1. **Service Coordination in UPI**:
   - UPI relies heavily on **data sharing** between services to process transactions. For example, when you enter a contact number to make a payment, UPI retrieves the UPI ID and username through shared data across services.
   - **IPC Role**: Data sharing ensures smooth coordination between different services involved in handling a UPI transaction.

#### 2. **Microservice Architecture**:
   - UPI operates on a **microservice architecture**, where different services handle different aspects of a transaction. These services communicate via **message queues**, ensuring that messages are processed in order without requiring the sender to wait for an immediate response.
   - **IPC Role**: Message queues allow services to send and receive messages efficiently without blocking.

#### 3. **Real-Time Processing**:
   - UPI processes thousands of transactions simultaneously. To prevent bottlenecks, UPI uses **asynchronous communication**, where the sender sends a message and continues processing other transactions, while the receiver processes the message later.
   - **IPC Role**: Asynchronous message passing ensures that multiple transactions can occur concurrently without waiting for individual processes to complete sequentially.

---

## Signal Handling

In Linux, **signals** are mechanisms used by the OS to manage and control processes. Signals can notify a process of events such as interruptions, termination requests, or changes in configuration. Each signal has a specific role, and processes can respond to these signals in various ways.

### **What are Signals?**

- A signal is a message sent by the OS to a process, indicating that a certain event has occurred or that the process should take a specific action.
- **Example**: A **traffic signal** tells drivers when to stop, go, or slow down. Similarly, signals in Linux inform processes to stop, continue, or take other actions.

### **Why are Signals Important?**

Signals allow for manual or automated intervention in running processes. They enable developers and system administrators to handle processes based on the system's state or user commands.

### **Common Types of Signals**

1. **SIGINT (Signal Interrupt)**:
   - **Command**: `Ctrl + C` to stop a process.
   - **Example**: If you're running a long script and realize that the input was incorrect, you can stop the script using `Ctrl + C`. This sends a **SIGINT** to the process, interrupting it.

2. **SIGTERM (Terminate Signal)**:
   - Gracefully requests a process to terminate, allowing it to clean up resources before exiting.

3. **SIGHUP (Hangup Signal)**:
   - Notifies a process that its controlling terminal has been disconnected. Often used to reload configuration files without restarting the process.

4. **SIGKILL (Kill Signal)**:
   - Forces a process to terminate immediately. Unlike **SIGTERM**, **SIGKILL** cannot be ignored or handled by the process.

### **Practical Signal Handling Commands**

- **`ps -ef`**: Displays a list of all running processes, showing process IDs (PIDs) and other details.
- **`kill PID`**: Sends a termination signal to a specific process using its PID.
- **`kill -9 PID`**: Sends a **SIGKILL** signal to forcefully terminate the process.
- **`kill -L`**: Lists all available signals on the system.

### **Practical Example**:
1. Create a simple script (`test.sh`) that runs for a certain period.
   ```bash
   vi test.sh
   sleep 60
   :wq!
   chmod 777 test.sh
   ./test.sh &
   ```

2. Use the `ps -ef` command to find the script's process ID, and use `kill` to terminate it:
   ```bash
   ps -ef | grep test.sh
   kill <PID>
   ```

3. You can also inspect the signal status of any process by checking the `/proc` directory:
   ```bash
   cat /proc/<PID>/status | grep Sig
   ```

---

## Advanced Commands for Inter-Process Communication

### **IPCS Command**

- **Usage**: The `ipcs` command displays information about active IPC resources such as message queues, shared memory segments, and semaphores.
- **Examples**:
   - `ipcs`: Lists all active IPC resources.
   - `ipcs -q`: Displays only the message queues.
   - `ipcs -m`: Shows shared memory segments.

### **IPCRM Command**

- **Usage**: The `ipcrm` command is used to remove specific IPC objects like message queues, shared memory, or semaphores.
- **Example**:
   - `ipcrm -q <QID>`: Removes the message queue identified by `<QID>`.

### **Top Command**

- **Usage**: The `top` command provides real-time system monitoring, displaying information about running processes, CPU usage, and memory utilization.
- **Important Fields**:
   - **PID**: Process ID of the running process.
   - **%CPU**: Percentage of CPU utilization by the process.
   - **%MEM**: Percentage of memory utilization by the process.
   - **Command**: The command or process running.

### **Niceness and Renice**

- **Niceness**:
   - Defines the priority of a new process on a scale from `-20`

 (highest priority) to `19` (lowest priority).
   - **Example**: 
     ```bash
     nice -n 15 gzip file.tar
     ```
     This assigns a lower priority to the `gzip` process, allowing more important processes to use the CPU first.

- **Renice**:
   - Adjusts the priority of an already running process.
   - **Example**:
     ```bash
     renice -5 -p <PID>
     ```
     This changes the priority of a process to a higher value (closer to `-20`), ensuring it gets more CPU time.

### **Interview Question Example**

**Scenario**: You receive an alert that the CPU utilization on your system is high, and at the same time, management informs you that critical tasks are blocked. How do you approach this situation?

1. **Step 1**: Use the `top` command to identify which processes are consuming the most CPU.
2. **Step 2**: Determine if these high-CPU processes are expected (e.g., important batch jobs) or if they are non-critical jobs that can be stopped.
3. **Step 3**: Kill or stop non-essential processes if necessary to reduce CPU load.
4. **Step 4**: For critical tasks, increase the **niceness** of the process, giving it a higher priority so that it gets more CPU time.
