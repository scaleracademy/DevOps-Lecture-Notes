# **Docker Container Networking and Security**

This document provides a detailed discussion on **Docker Storage**, **Storage Drivers**, **NFS (Network File System)**, and **Docker Networking**. It explains how data is stored and managed in Docker containers and how Docker networking enables interaction between isolated containers.

---

## **Topics to be discussed:**

1. Docker Storage  
2. Storage Drivers  
3. NFS (Network File System)  
4. Docker Networking  

---

# **Docker Storage**

Docker Storage refers to the methods used to **persist data** in Docker containers and manage **container file systems**.

---

### **Why Do We Need Storage in Docker?**  
1. **Data Persistence**: Ensures that data remains available even if the container is deleted.  
2. **Scalability and Flexibility**: Allows storage to be adjusted as needed for various applications.  
3. **Efficient Resource Management**: Prevents duplication of data across containers.  
4. **High Availability and Reliability**: Ensures data remains accessible during container failures.

---

### **Types of Docker Storage**

1. **Volumes**  
   - Volumes are **directories** or **files** outside the container’s file system, managed by Docker.  
   - They are **independent of the container’s lifecycle**.  
   - Even if the container is deleted, the volume persists.

   **Command to Create a Volume**:  
   ```bash
   docker volume create my-volume
   ```

   **Command to Use a Volume**:  
   ```bash
   docker run -d -v my-volume:/data <image_name>
   ```

   **Example Illustration**:  
   ![Docker Storage](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/100/523/original/DockerStorage.png?1734448525)

---

2. **Bind Mounts**  
   - **Bind mounts** map a **host directory** to a **container directory**.  
   - Changes in either directory will reflect in the other.

   **Command to Use Bind Mounts**:  
   ```bash
   docker run -d -v /host/data:/container/data my_image
   ```

---

3. **Tmpfs Mounts**  
   - **Temporary file systems** that store data in **RAM** instead of disk storage.  
   - Data is **lost** when the container stops.  
   - Useful for **caching** and **temporary data**.

   **Command to Use Tmpfs Mounts**:  
   ```bash
   docker run -d --tmpfs /container/tmp my_image
   ```

---

# **Storage Drivers**

Docker uses **Storage Drivers** to manage how data is **stored and accessed** in the container’s filesystem.

---

### **Types of Storage Drivers**

1. **Overlay2 (Default Driver)**  
   - Uses **Copy-on-Write** mechanism.  
   - A **base image** is shared across multiple containers, with each container having its own **read-write layer**.

   **Example:**  
   - Containers **C1**, **C2**, and **C3** use the same base image layer, but each has a unique **read-write layer** for modifications.

---

2. **AUFS (Advanced Multilayer Universal File System)**  
   - Supports **Copy-on-Write**.  
   - Combines multiple layers of files into a **unified view**.

---

3. **Device Mapper**  
   - Uses **block-level operations** to allocate storage.  
   - Ideal for systems that need **block-level management** and **high performance**.

---

### **Important Command: Cleaning Unused Volumes**  
```bash
docker volume prune
```
- Deletes **unused volumes** to free up space.

---

# **NFS (Network File System)**

### **What is NFS?**  
NFS is a **shared storage solution** that allows multiple machines to **access the same storage** over a network.

---

### **When to Use NFS?**  
- When you have **multiple machines** and want them to use **shared storage**.  
- **Example:**  
  - You have **3 servers** that need to access the **same database files**.

---

### **Setup Steps for NFS**  
1. **Install NFS Kernel on the Server**  
   ```bash
   apt-get install nfs-kernel-server
   ```
2. **Install NFS on Client Machines**  
   ```bash
   apt-get install nfs-common
   ```

---

# **Docker Networking**

Docker Networking allows **containers** to communicate with:  
- Each other.  
- The **host machine**.  
- **External networks**.

---

### **Why is Docker Networking Important?**  
- Docker containers are **isolated** by default.  
- Networking provides a **logical layer** for containers to **interact** securely.

---

### **Types of Docker Networks**

1. **Bridge Network**  
   - The **default network** for Docker containers.  
   - Containers can communicate **within the same host**.  
   - Ideal for **local development**.

2. **Host Network**  
   - Removes the **network isolation** between the container and the host.  
   - The container shares the **host’s network stack**.

3. **None Network**  
   - Completely disables networking for the container.  
   - Ideal for **security-focused** applications.

4. **Overlay Network**  
   - Used in **Docker Swarm** to enable communication between containers across **multiple hosts**.

5. **Macvlan Network**  
   - Assigns a **unique MAC address** to each container.  
   - Containers appear as **separate devices** on the network.

---

# **Summary of Key Commands**

| **Command**                            | **Description**                                     |
|----------------------------------------|-----------------------------------------------------|
| `docker volume create <name>`           | Creates a Docker volume.                           |
| `docker run -d -v <volume>:/path`       | Mounts a volume inside the container.               |
| `docker volume prune`                   | Removes unused volumes.                            |
| `docker network create <name>`          | Creates a new Docker network.                      |
| `docker network ls`                     | Lists all Docker networks.                         |
| `docker network connect <net> <cont>`   | Connects a container to a network.                 |
| `docker run --network=<network>`        | Runs a container in a specific network.             |

---

# **Example Docker Networking Commands**

1. **Creating a Bridge Network**  
   ```bash
   docker network create my_bridge
   ```

2. **Running a Container in a Custom Network**  
   ```bash
   docker run -d --name my_container --network=my_bridge nginx
   ```

3. **Inspecting a Network**  
   ```bash
   docker network inspect my_bridge
   ```

4. **Connecting an Existing Container to a Network**  
   ```bash
   docker network connect my_bridge my_container
   ```

---

# **Conclusion**

In this session, we explored:  
- **Docker Storage** methods for persisting data in containers.  
- **Storage Drivers** used to manage container filesystems.  
- **NFS (Network File System)** for shared storage across machines.  
- **Docker Networking** to enable communication between containers and external systems.
