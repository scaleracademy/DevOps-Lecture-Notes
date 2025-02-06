# **Docker Orchestration & Container Storage**

This document provides an overview of **Docker Compose**, **Docker Stack**, **Node Labels**, and **Container Storage** concepts, including practical implementation steps for orchestrating multi-container applications using Docker Swarm.

---

## **Topics to be discussed:**
1. Docker Compose  
2. Docker Stack  
3. Node Labels  
4. Storage  

---

# **Docker Service in Docker Swarm**

### **What is Docker Swarm?**  
Docker Swarm is a **container orchestration tool** that allows you to manage a cluster of Docker nodes. It provides features like **service discovery**, **load balancing**, and **rolling updates** across multiple nodes.

### **Managing Services in Docker Swarm**

1. **Creating a Service**  
   ```bash
   docker service create --name web --publish published=80,target=80 --replicas=3 nginx
   ```
   - Creates a service named **web** with 3 replicas (containers) running **nginx**.

2. **Scaling a Service**  
   ```bash
   docker service scale web=5
   ```
   - Adjusts the number of replicas to 5.  
   - Swarm Manager automatically distributes the replicas across available nodes.

3. **Updating a Service**  
   ```bash
   docker service update --image <image_name> web
   ```
   - Updates the service to use a new image.

---

# **Docker Compose**

### **What is Docker Compose?**  
**Docker Compose** simplifies the management of **multi-container applications** by defining the entire application stack in a single **YAML file**.

---

### **Why Use Docker Compose?**  
- Manages **complex configurations** for multi-container applications.  
- Avoids running lengthy Docker CLI commands for each container.  
- Provides **scaling**, **logging**, and **networking** for services.

---

### **Key Commands in Docker Compose**

| **Command**                  | **Description**                                      |
|------------------------------|------------------------------------------------------|
| `docker compose up`           | Starts all containers defined in the `docker-compose.yml` file. |
| `docker compose down`         | Stops and removes all containers and networks created by the compose file. |
| `docker compose logs`         | Shows logs from all containers.                     |
| `docker compose up --scale`   | Scales a specific service to a specified number of replicas. |

---

### **Steps to Use Docker Compose**

1. **Create a `docker-compose.yml` file**  
   Example:  
   ```yaml
   version: "3.8"
   services:
     web:
       image: nginx
       ports:
         - "80:80"
   ```

2. **Run the Compose File**  
   ```bash
   docker compose up
   ```

3. **Scale the Service**  
   ```bash
   docker compose up --scale web=3
   ```

---

# **Docker Stack**

### **What is Docker Stack?**  
**Docker Stack** is used to manage **multi-container applications** in a **Swarm environment**. It runs the same **Compose file** but in a **multi-host cluster**.

---

### **Difference Between Docker Compose and Docker Stack**

| **Docker Compose**                  | **Docker Stack**                        |
|-------------------------------------|-----------------------------------------|
| Used for **local development**.     | Used for **production orchestration**.  |
| Works on a **single host**.         | Works across **multiple hosts**.        |
| **Manual scaling**.                 | **Automated scaling**.                  |
| No **fault tolerance**.             | Provides **fault tolerance**.           |

---

### **Key Docker Stack Commands**

| **Command**                           | **Description**                                     |
|---------------------------------------|-----------------------------------------------------|
| `docker stack deploy -c <file> <name>` | Deploys a stack from a compose file.               |
| `docker stack ls`                      | Lists all running stacks.                          |
| `docker stack services <stack_name>`   | Lists services within a specific stack.            |
| `docker stack ps <stack_name>`         | Lists tasks (containers) running in the stack.     |

---

### **Practical Implementation of Docker Stack**

1. **Create a `docker-compose.yml` file**  
   Example:  
   ```yaml
   version: "3.8"
   services:
     web:
       image: nginx
       ports:
         - "80:80"
   ```

2. **Deploy the Stack**  
   ```bash
   docker stack deploy -c docker-compose.yml my_stack
   ```

3. **List Running Stacks**  
   ```bash
   docker stack ls
   ```

4. **Check Services in a Stack**  
   ```bash
   docker stack services my_stack
   ```

5. **List Tasks (Containers) in a Stack**  
   ```bash
   docker stack ps my_stack
   ```

---

# **Node Labels in Docker Swarm**

### **What is a Node Label?**  
**Node Labels** are used to assign **attributes to nodes**. They help in controlling **where services are deployed** based on node capabilities (e.g., memory, CPU).

---

### **Why Use Node Labels?**  
Imagine you have two nodes:  
- **Node 1**: High memory (ideal for databases).  
- **Node 2**: Standard memory (suitable for web servers).  

Without labels, Docker Swarm might deploy the database on **either node**. By assigning **labels**, you can ensure that the **database service** is deployed only on **high-memory nodes**.

---

### **Steps to Assign Node Labels**

1. **Add a Label to a Node**  
   ```bash
   docker node update --label-add high-memory=true <node_id>
   ```

2. **Assign Constraints in `docker-compose.yml`**  
   Example:  
   ```yaml
   version: "3.8"
   services:
     db:
       image: mysql
       deploy:
         placement:
           constraints:
             - node.labels.high-memory == true
   ```

---

# **Storage in Docker Containers**

Docker provides **three types of storage options** for containers:

| **Storage Type**      | **Description**                                                  |
|-----------------------|------------------------------------------------------------------|
| **Volumes**           | Managed by Docker and stored in `/var/lib/docker/volumes/`.      |
| **Bind Mounts**        | Maps a directory from the host to a directory inside the container. |
| **Tmpfs Mounts**       | Temporary storage in RAM, lost when the container stops.         |

---

### **1. Volumes**  
- Docker-managed storage.  
- **Recommended** for most applications.  
- Data persists even after the container is deleted.  

**Command to Create a Volume**:  
```bash
docker volume create my_volume
```

---

### **2. Bind Mounts**  
- Maps a specific **host directory** to a container directory.  
- Useful for **local development**.  

**Command to Use a Bind Mount**:  
```bash
docker run -v /host/path:/container/path ubuntu
```

---

### **3. Tmpfs Mounts**  
- Stores data in **RAM**, ensuring **high speed**.  
- **Non-persistent** storage.  

**Command to Use a Tmpfs Mount**:  
```bash
docker run --tmpfs /app tmpfs-example
```

---

### **Practical Example of Volume Usage**

1. **Create a Volume**  
   ```bash
   docker volume create my_data
   ```

2. **Run a Container Using the Volume**  
   ```bash
   docker run -d --name my_container -v my_data:/data nginx
   ```

3. **Inspect the Volume**  
   ```bash
   docker volume inspect my_data
   ```

---

# **Summary of Key Commands**

| **Command**                          | **Description**                                      |
|--------------------------------------|------------------------------------------------------|
| `docker compose up`                  | Starts containers from a `docker-compose.yml` file. |
| `docker stack deploy -c <file> <name>` | Deploys a stack in a Swarm environment.             |
| `docker node update --label-add`     | Adds a label to a node.                             |
| `docker volume create <name>`        | Creates a Docker volume.                            |
| `docker run -v <volume>:<path>`      | Mounts a volume inside a container.                 |
