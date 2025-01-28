# **Docker Basics (Continued) & Docker Swarm**

This document covers advanced Docker topics, including **Storage Drivers**, **Logging Drivers**, **Namespaces**, **Control Groups**, **Docker Images**, and **Dockerfile** components. It provides detailed instructions and commands to help learners gain hands-on experience.

---

## **Agenda of the Lecture**
1. Selecting a Storage Driver  
2. Logging Drivers  
3. Namespace  
4. Control Groups (C Groups)  
5. Docker Images  
6. Dockerfile  

---

# **Selecting a Storage Driver**

### **What is a Storage Driver?**  
A **Storage Driver** is responsible for managing how data is **stored and accessed** within Docker containers. It handles how layers of images and containers interact with the filesystem.

---

### **Types of Storage Drivers**

1. **Overlay2 (Default Driver)**  
   - Most commonly used and default on Linux systems.  
   - Uses a **layered filesystem** where each Docker layer is stored as a snapshot.

2. **Device Mapper**  
   - Uses **thin provisioning** and **snapshots** to manage images and containers as virtual blocks.

3. **Btrfs**  
   - **Binary Tree Filesystem**.  
   - Supports **subvolumes** for flexible storage management.

4. **ZFS (Zettabyte File System)**  
   - Provides **copy-on-write**, **deduplication**, and **data protection** features.

---

### **Commands to Check and Change Storage Drivers**

1. **Check current storage driver**:  
   ```bash
   docker info | grep -i storage
   ```
2. **Change the storage driver** by modifying the **daemon.json** file:  
   ```bash
   vi /etc/docker/daemon.json
   ```
   Example configuration:  
   ```json
   {
       "storage-driver": "devicemapper"
   }
   ```

---

# **Logging Drivers**

### **What is a Logging Driver?**  
A **Logging Driver** manages how logs are generated, stored, and processed by Docker containers. By default, Docker captures logs through **stdout** and **stderr**.

---

### **Types of Logging Drivers**  
1. **json-file (Default)**  
2. **syslog**  
3. **awslogs**  
4. **fluentd**  
5. **journald**

---

### **Configuring Logging Drivers**  
To configure a logging driver, modify the **daemon.json** file:  
```bash
vi /etc/docker/daemon.json
```
Example configuration:  
```json
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "10m",
        "max-file": "3"
    }
}
```

---

# **Namespace**

### **What is a Namespace?**  
A **Namespace** is a **Linux kernel feature** that Docker uses to isolate resources such as processes, users, and networks in containers.

---

### **Types of Namespaces**

| **Namespace Type** | **Description**                                                |
|--------------------|----------------------------------------------------------------|
| **PID**            | Isolates process IDs, ensuring container processes are isolated. |
| **User**           | Maps user and group IDs inside the container.                   |
| **MNT**            | Isolates filesystem mount points.                               |
| **IPC**            | Isolates inter-process communication resources.                 |
| **NET**            | Provides separate network interfaces for each container.        |

---

# **Control Groups (C Groups)**

### **What are C Groups?**  
**Control Groups (C Groups)** are used by Docker to **limit and manage resources** such as CPU, memory, and disk I/O for containers.

---

### **Example of Resource Limitation Using C Groups**

1. **Run an Nginx container with default resources**:  
   ```bash
   docker run -d --name first_container nginx
   ```

2. **Run a container with specific resource limits**:  
   ```bash
   docker run -d --name my_container --cpus="0.1" --memory="500m" nginx
   ```
   - **CPU Allocation**: 0.1 core  
   - **Memory Allocation**: 500 MB  

---

# **Docker Images**

### **What is a Docker Image?**  
A **Docker Image** is a **blueprint** used to create containers. It is a **read-only** template that contains instructions for building a container.

---

### **Ways to Create a Docker Image**

1. **Using a Dockerfile**  
2. **Using Commit Changes from a Container**  
   Example:  
   ```bash
   docker run -it ubuntu
   ```
   Make changes inside the container, then commit the changes:  
   ```bash
   docker commit <container_id> new_image_name
   ```

3. **Using Docker Compose**  
   - Create a **docker-compose.yml** file to define multi-container applications.

---

# **Dockerfile**

### **What is a Dockerfile?**  
A **Dockerfile** is a text file containing instructions to build a Docker image.

---

### **Steps to Create a Dockerfile**  
1. **Create a Dockerfile**:  
   ```bash
   vi Dockerfile
   ```
2. **Write the following in the Dockerfile**:  
   ```dockerfile
   FROM ubuntu:latest
   WORKDIR /app
   COPY abc.txt /app/abc.txt
   CMD ["sleep", "infinity"]
   ```

3. **Build the Docker Image**:  
   ```bash
   docker build -t my_ubuntu_app .
   ```

4. **Run the Container**:  
   ```bash
   docker run -d --name my_container_2 my_ubuntu_app
   ```

5. **Check Running Containers**:  
   ```bash
   docker ps
   ```

6. **Access the Container**:  
   ```bash
   docker exec -it <container_id> /bin/bash
   ```

---

# **Components of a Dockerfile**

| **Instruction** | **Description**                                                  |
|-----------------|------------------------------------------------------------------|
| **FROM**        | Defines the base image.                                          |
| **RUN**         | Executes commands in a new layer.                                |
| **COPY**        | Copies files from the local machine to the Docker image.         |
| **ADD**         | Similar to COPY but supports remote URLs and file extraction.    |
| **WORKDIR**     | Sets the working directory inside the container.                 |
| **CMD**         | Defines the default executable for the Docker image.             |
| **ENTRYPOINT**  | Configures the container to run as an executable.                |
| **ENV**         | Sets environment variables in the image.                         |
| **VOLUME**      | Creates a mount point for persistent data storage.               |

---

### **Difference Between CMD and ENTRYPOINT**  

| **CMD**                  | **ENTRYPOINT**             |
|--------------------------|----------------------------|
| Can be overridden         | Cannot be overridden       |
| Defines the default command | Configures the container to run as an executable |

---

### **Example Dockerfile with Components**
```dockerfile
FROM ubuntu:latest
RUN apt-get update && apt-get install -y python3
WORKDIR /app
COPY . /app
CMD ["python3", "-m", "http.server", "8080"]
```

---

# **Key Docker Commands Recap**

| **Command**                | **Description**                                                |
|----------------------------|----------------------------------------------------------------|
| `docker ps`                 | Lists all running containers.                                  |
| `docker pull <image>`       | Pulls an image from the Docker registry.                       |
| `docker run <image>`        | Runs a container based on the given image.                     |
| `docker stop <container_id>`| Stops a running container.                                     |
| `docker exec -it <id>`      | Accesses a running container.                                  |
| `docker build -t <name> .`  | Builds a Docker image using a Dockerfile.                      |
| `docker commit <id> <name>` | Creates an image from a container's changes.                   |

