# **Docker Basics**

This document covers **YAML**, the history and need for **Docker**, and **Docker architecture**. It also provides detailed explanations of Docker commands with live examples.

---

## **Topics to be covered**
1. YAML Introduction  
2. How Docker Came into the Picture  
3. Docker Basics  

---

# **YAML (YAML Ain’t Markup Language)**

### **What is YAML?**  
YAML is a **human-readable data serialization format** often used in **configuration files** for applications like Kubernetes, Docker Compose, and CI/CD pipelines.

### **Benefits of YAML**  
- **Better readability** compared to JSON or XML.  
- **Flexible** structure to support complex configurations.  

### **Sample YAML File**
```yaml
Stages:
  - build
  - test
  - deploy

build-job:
  Stage: build
```

### **Key Concepts in YAML**
1. **Indentation**  
   YAML relies on correct indentation to structure data. Misalignment will result in parsing errors.  
2. **Key-Value Pairs**  
   Example:  
   ```yaml
   name: Deepak
   ```
3. **Arrays**  
   YAML supports arrays as lists.  
   Example:  
   ```yaml
   fruits:
     - apple
     - banana
     - cherry
   ```
4. **Anchors (&) and Aliases (*)**  
   - **Anchors** (`&`): Define a reusable value.  
   - **Aliases** (`*`): Reference an anchor.  

---

# **How Docker Came into the Picture?**

### **1. Physical Machines**  
In traditional setups, applications ran on physical machines.  
**Problem**: Resource utilization was poor, as each machine could only run one application, even if it used a fraction of the machine's capacity.

---

### **2. Virtual Machines (VMs)**  
Virtual Machines allowed multiple applications to run on a single machine by **virtualizing hardware resources**.  
**Problem**:  
- Each VM required a separate **operating system**, consuming significant resources.  
- Redundant overhead from running multiple OS instances.

---

### **3. Containers**  
Containers solve the inefficiencies of VMs by **sharing the host operating system kernel** across multiple isolated environments.  

**Benefits**:
- Lightweight and faster compared to VMs.  
- Efficient resource utilization.  

---

### **Architecture of Virtual Machines**  
- **Infrastructure** (Physical hardware)  
- **Hypervisor** (Software that creates and manages virtual machines)  
- Each VM runs its own **Operating System** and application stack.  

**Diagram**:  
![VM Architecture](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/098/996/original/vm.png?1733409309)

---

### **Architecture of Containers**  
- **Infrastructure**  
- **Host Operating System**  
- **Container Engine** (e.g., Docker, Containerd)  
- Containers run **isolated applications** without the need for separate operating systems.

**Diagram**:  
![Container Architecture](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/099/001/original/containersArchitecture.png?1733409655)

---

### **Difference Between VMs and Containers**  
| **Aspect**           | **Virtual Machines**             | **Containers**                      |
|----------------------|----------------------------------|-------------------------------------|
| OS Dependency        | Each VM has its own OS           | Containers share the host OS kernel |
| Resource Utilization | Less efficient                   | More efficient                      |
| Startup Time         | Slow                             | Fast                                |
| Size                 | Heavy                            | Lightweight                         |

---

# **Docker Architecture**

Docker uses a client-server architecture comprising **Docker Client**, **Docker Daemon**, and **Docker Registry**.

---

### **1. Docker Client**  
- Interface used by the user to interact with Docker.  
- Commands like `docker pull`, `docker run`, and `docker ps` are executed through the client.

---

### **2. Docker Host**  
The Docker Host contains the following components:  
#### **a) Docker Daemon**  
- Interacts with the Docker Client.  
- Builds images from **Dockerfiles**.  
- Creates and manages containers based on images.  

#### **b) Images**  
- Images are **templates** used to create containers.  
- They are **read-only** and consist of **multiple layers**.  

#### **c) Containers**  
- A **running instance** of an image.  
- Containers are lightweight, portable, and isolated.  

---

### **3. Docker Registry**  
- A **repository** that stores Docker images.  
- Examples: **Docker Hub**, **GitHub Container Registry**.  
- Developers push images to the registry, and production engineers pull them to deploy applications.

---

### **Flow of Docker Components**  
1. **Docker Client** sends a request to **Docker Daemon**.  
2. **Docker Daemon** fetches the required image from the **Docker Registry**.  
3. The image is used to create and run **containers**.

**Diagram**:  
![Docker Integration](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/099/013/original/integration.png?1733412240)

---

# **Docker Commands**

Here are essential Docker commands and their usage:

| **Command**             | **Description**                                          |
|-------------------------|----------------------------------------------------------|
| `docker ps`             | Lists all running containers.                            |
| `docker pull <image>`   | Pulls an image from the Docker registry.                 |
| `docker run <image>`    | Runs a container based on the given image.               |
| `docker stop <container_id>` | Stops a running container.                           |
| `docker logs <container_id>` | Displays logs from the container.                    |
| `docker images`         | Lists all images available locally.                      |

---

### **Examples of Docker Commands**

1. **Pulling an Image**  
   ```bash
   docker pull ubuntu:latest
   ```
   - Pulls the latest version of the Ubuntu image.

2. **Running a Container in Interactive Mode**  
   ```bash
   docker run -it ubuntu
   ```
   - Starts a container and allows you to interact with it through the terminal.

3. **Exiting a Container**  
   ```bash
   exit
   ```
   - Exits the container, which stops it as well.

4. **Stopping a Container**  
   ```bash
   docker stop <container_id>
   ```
   - Stops a running container.

5. **Listing All Containers**  
   ```bash
   docker ps -a
   ```
   - Lists all containers, including stopped ones.

---

### **Running Containers in Detached Mode**  
```bash
docker run -d ubuntu
```
- Runs the container in **detached mode**, meaning it will run in the background.

---

### **Accessing a Running Container**  
```bash
docker exec -it <container_id> /bin/bash
```
- Opens a shell inside the running container.

---

### **Exiting a Container Without Stopping**  
Use the key combination:  
**CTRL+P + CTRL+Q**  
- This will exit the container without stopping it.

---

# **Summary of Docker Basics**
| **Concept**       | **Description**                                           |
|-------------------|-----------------------------------------------------------|
| Docker Client     | Interface for users to interact with Docker.              |
| Docker Daemon     | Handles images, containers, and interactions with registries. |
| Docker Images     | Templates used to create containers.                      |
| Docker Containers | Running instances of images.                              |
| Docker Registry   | Repository that stores Docker images.                     |
