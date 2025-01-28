# **Docker Container Networking and Security (Continued)**

This document covers **Docker Networking types**, a **demo on creating a bridge network**, **common interview questions**, and **Docker security best practices**.

---

## **Topics to be discussed:**
1. Docker Networking  
2. Demo: Creating a Network  
3. Interview Questions  
4. Security - Best Practices  

---

# **Docker Networking**

Docker Networking is essential for enabling communication between containers, the host system, and external networks. Docker provides multiple networking modes for different use cases.

---

### **Types of Docker Networks**

| **Network Type** | **Description**                                    |
|------------------|----------------------------------------------------|
| **Bridge**       | Default network. Containers can communicate within the same host. |
| **Host**         | Removes network isolation between the container and the host. |
| **None**         | Disables networking for a container.               |
| **Overlay**      | Enables communication between containers on different hosts. |
| **Macvlan**      | Gives each container a unique MAC address, making them appear as physical devices on the network. |

---

## **1. Bridge Network**  
A **Bridge Network** is the **default network** created by Docker. Containers on the same bridge network can communicate with each other using **names** or **IP addresses**.

### **Key Commands for Bridge Network**
- **Create a Custom Bridge Network**:  
  ```bash
  docker network create my_bridge_network
  ```
- **Run a Container in the Bridge Network**:  
  ```bash
  docker run -d --name DB --network my_bridge_network nginx
  ```
- **Attach an Existing Container to the Network**:  
  ```bash
  docker network connect my_bridge_network <container_name>
  ```

---

## **2. Host Network**  
In a **Host Network**, the container shares the **host’s network stack**, removing network isolation.  
- **No Port Isolation**: Containers share the same ports as the host.  
- **Security Issue**: Port conflicts can occur.

### **Command to Use Host Network**:  
```bash
docker run -d --name app --network host <image_name>
```

---

## **3. None Network**  
A **None Network** completely disables networking for a container.  
- Useful for **containers that do not require external communication**.

### **Command to Use None Network**:  
```bash
docker run -d --name app --network none
```

---

## **4. Overlay Network**  
An **Overlay Network** enables communication between containers across **multiple Docker hosts**.  
- Primarily used in **Docker Swarm**.  
- It creates a **virtual network** that spans across nodes.

---

## **5. Macvlan Network**  
A **Macvlan Network** assigns each container a **unique MAC address**, making the containers appear as **separate physical devices** on the network.

### **Command to Create a Macvlan Network**:  
```bash
docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 -o parent=eth0 network_name
```

---

# **Demo: Creating a Bridge Network**

### **Step-by-Step Demo Commands**

1. **List All Docker Networks**:  
   ```bash
   docker network ls
   ```

2. **Create a Bridge Network**:  
   ```bash
   docker network create my_bridge_network
   ```

3. **Inspect the Created Network**:  
   ```bash
   docker network inspect my_bridge_network
   ```

4. **Run Containers in the Network**:  
   - **Container 1** (using **nginx**):  
     ```bash
     docker run -d --name container1 --network my_bridge_network nginx
     ```
   - **Container 2** (using **busybox**):  
     ```bash
     docker run -d --name container2 --network my_bridge_network busybox
     ```

5. **Ping Between Containers**:  
   - **Enter Container 1**:  
     ```bash
     docker exec -it container1 /bin/sh
     ```
   - **Ping Container 2**:  
     ```bash
     ping container2
     ```

6. **Disconnect a Network**:  
   ```bash
   docker network disconnect my_bridge_network container1
   ```

---

# **Interview Questions**

### **Q1: How Will You Expose Your Containers Externally?**

**Answer:** There are multiple ways to expose Docker containers:  
1. **Port Binding**:  
   Use the `-p` option to bind the container port to a host port.  
   ```bash
   docker run -d -p 8080:80 nginx
   ```

2. **Docker Compose**:  
   Define port binding in the `docker-compose.yml` file.  
   ```yaml
   ports:
     - "8080:80"
   ```

3. **Swarm Services**:  
   Use the `--publish` option to expose services.  
   ```bash
   docker service create --name my_service --publish published=8080,target=80 nginx
   ```

4. **Proxy Servers**:  
   Use **NGINX** or **HAProxy** as a **reverse proxy** to handle requests to the container.

---

### **Q2: What Are Common Issues with Docker Containers and How Do You Troubleshoot Them?**

| **Issue**                   | **Troubleshooting Steps**                       |
|-----------------------------|-------------------------------------------------|
| **Connectivity Issues**      | Check container network settings.              |
| **DNS Resolution**           | Check if the container can resolve DNS names.  |
| **Port Binding Conflicts**   | Use `netstat -tupln` to check for conflicts.   |
| **Performance Degradation**  | Monitor resource usage and network traffic.    |

### **Troubleshooting Commands**
1. **Inspect Container Networks**:  
   ```bash
   docker network inspect <network_name>
   ```

2. **Check Connectivity Using Ping**:  
   ```bash
   docker exec -it <container_id> ping <target>
   ```

3. **Check DNS Settings**:  
   - By default, Docker uses the **host DNS settings**.  
   - To change the DNS:  
     ```bash
     docker run -d --name my_container --dns 8.8.8.8 nginx
     ```

4. **Check Ports in Use**:  
   ```bash
   netstat -tupln
   ```

5. **Check Container Logs**:  
   ```bash
   docker logs <container_id>
   ```

6. **Monitor Network Traffic Using tcpdump**:  
   ```bash
   tcpdump -i eth0
   ```

---

# **Security - Best Practices**

### **1. Signing Images**  
- Use **signed images** to ensure the authenticity of Docker images.  
- **Command to Check Image Signature**:  
  ```bash
  docker trust inspect --pretty nginx
  ```

---

### **2. MTLS (Mutual TLS Authentication)**  
**MTLS** ensures that both the client and server authenticate each other using **certificates**.

#### **Steps to Enable MTLS:**
1. **Generate Certificates**  
   - Create **CA**, **server**, and **client certificates**.

2. **Configure Docker Daemon**  
   - Modify the **`daemon.json`** file:  
     ```json
     {
         "tls": true,
         "tlscacert": "/path/to/ca.pem",
         "tlscert": "/path/to/server-cert.pem",
         "tlskey": "/path/to/server-key.pem",
         "tlsverify": true
     }
     ```

3. **Restart Docker Daemon**  
   ```bash
   systemctl restart docker
   ```

---

### **3. Generating a Certificate (Practical Example)**

#### **Steps to Generate Certificates:**
1. **Generate CA Key & Certificate**  
2. **Generate Server Key & Certificate**  
3. **Sign the Server Certificate**  
4. **Generate Client Key & Certificate**  
5. **Sign the Client Certificate**

# **Summary of Key Commands**

| **Command**                        | **Description**                                    |
|------------------------------------|----------------------------------------------------|
| `docker network create`             | Creates a new Docker network.                     |
| `docker network ls`                 | Lists all Docker networks.                        |
| `docker network inspect`            | Inspects a specific network.                      |
| `docker run --network <network>`    | Runs a container in a specific network.           |
| `netstat -tupln`                    | Lists all active ports and services.              |
| `docker trust inspect --pretty`     | Checks the signing authority of a Docker image.   |

---

# **Conclusion**

This session covered **Docker Networking**, a **demo on creating networks**, common **interview questions**, and **security best practices**.  
Make sure to practice using **networks and security features** to strengthen your understanding of Docker.
