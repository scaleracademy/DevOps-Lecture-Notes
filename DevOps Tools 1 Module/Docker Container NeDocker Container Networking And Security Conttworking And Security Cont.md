# Typed Notes of Docker Container Networking and Security

# 🌐 **Docker Networking**


### 🔎 **Overview of Docker Networking**

- Containers are isolated environments. By default, they don’t know about each other unless Docker Swarm is used.
- Containers act like **small virtual machines** and sometimes need to communicate with each other for a single application to function properly.
- To achieve this, Docker provides **networking capabilities** that connect containers, allowing them to communicate securely and efficiently.
- Docker networks are built using **drivers**. Each type of network corresponds to a built-in Docker driver.

---

### 🧩 **Types of Docker Networks**

| **Network Type** | **Description**                                            |
|------------------|------------------------------------------------------------|
| Bridge           | Default network for containers on a single host.            |
| Host             | Shares the host’s network namespace with the container.     |
| None             | Disables all networking for a container.                   |
| Overlay          | Connects containers across multiple Docker hosts.           |
| Macvlan          | Assigns a unique MAC address to containers, making them appear as physical devices on the network. |

---

## 🛠️ **Basic Docker Networking Commands**

1. **List all networks:**
   ```bash
   docker network ls
   ```
2. **Inspect a network’s configuration:**
   ```bash
   docker network inspect <network_name>
   ```

---

## 🌉 **Bridge Network (Default Network)**

### 📝 **What is a Bridge Network?**
- The **default network** assigned to containers when no other network is specified.
- Each container has its own **IP address** within the bridge network.
- You can create **custom bridge networks** to isolate groups of containers.

### 🧪 **Scenario: Custom Bridge Network**
- Containers **C1** and **C2** use the default bridge network.
- Containers **C3** and **C4** need to be isolated but must communicate with each other.  
  Solution: Create a **custom bridge network** and assign **C3** and **C4** to it.

📷 *Diagram: Bridge Network*  
![Bridge Network](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/102/189/original/bridgenetwork.png?1736177966)

### 🔗 **How Bridge Network Works?**
- A **web server** container and a **database** container are isolated by default.
- To allow communication, both containers need to be assigned to a **bridge network**.

📷 *Diagram: Working of Bridge Network*  
![Bridge Network Interaction](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/102/191/original/workingofbridgenetwork.png?1736178197)

**Command to create a custom bridge network:**
```bash
docker network create my_bridge_network
```

---

## 🌐 **Host Network**

### 📝 **What is a Host Network?**
- Removes **network isolation** between the container and the Docker host.
- The container shares the host’s network namespace, meaning:
  - **No port mapping is required.**
  - The container has **direct access** to the host's network interfaces.

**Use case:**  
- When you need **low-latency communication** between the host and the container.  
- Ideal for **performance monitoring** or **network traffic analysis**.

**Command to run a container with host networking:**
```bash
docker run -d --name perf_app --network host my_perf_image
```

---

## 🚫 **None Network**

### 📝 **What is a None Network?**
- Disables **all networking** for a container.
- The container is completely **isolated** from the network.

**Command to create a container with no networking:**
```bash
docker run -d --name isolated_task --network none image_name
```

---

## 🕸️ **Overlay Network**

### 📝 **What is an Overlay Network?**
- **Overlay networks** connect containers running on **different Docker hosts**.
- Used in **Docker Swarm clusters** to enable container communication across nodes.
- Essential for **scaling applications** across multiple hosts.

📷 *Diagram: Overlay Network*  
![Overlay Network](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/102/197/original/overlay_network.png?1736179120)

**Command to create an overlay network:**
```bash
docker network create -d overlay name_of_network
```

**Example of creating a service on an overlay network:**
```bash
docker service create --name web_service --network name_of_overlay_network --replicas 3 image_name
```

---

## 📡 **Macvlan Network**

### 📝 **What is a Macvlan Network?**
- Allows Docker containers to **appear as physical devices** on the network.
- Each container is assigned a unique **MAC address** and behaves like a separate machine.

**Use case:**  
- Ideal for **data centers** where containers need to run services like **VPN servers** or **firewalls** while appearing as distinct network devices.

**Command to create a Macvlan network:**
```bash
docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.1 -o parent=eth0 name_of_network
```

---

# ❓ **Interview Questions on Docker**

### 💡 **Q1: How will you expose your container externally?**

There are several ways to expose a container externally:

1. **Port Binding:**  
   - Map a port on the **Docker host** to a port on the **container** using the `-p` flag.  
   Example:  
   ```bash
   docker run -d -p 8080:80 nginx
   ```

2. **Using Docker Compose:**  
   - Define port mappings in the `docker-compose.yml` file.

3. **Using Docker Swarm Services:**  
   - Use the `--publish` flag to expose services to external networks.

4. **Using Proxy Servers (e.g., Nginx):**  
   - Use Nginx to route requests to specific services based on the request path.  
   Example Nginx configuration:
   ```nginx
   server {
       listen 80;
       server_name example.com;

       location /service1 {
           proxy_pass http://service1:80;
       }

       location /service2 {
           proxy_pass http://service2:80;
       }
   }
   ```

---

### 💡 **Q2: Common Issues in Docker and Their Troubleshooting Steps**

| **Issue**             | **Description**                                      | **Troubleshooting Steps**                              |
|-----------------------|------------------------------------------------------|-------------------------------------------------------|
| Connectivity Issues   | Containers can't communicate                         | Check network configurations and logs.                |
| DNS Resolution Failure | Containers unable to resolve DNS names               | Inspect `/etc/resolv.conf` inside the container.       |
| Port Binding Conflicts | Port already in use                                  | Use `netstat -tulpn` to find conflicting processes.    |

**Debugging Tools:**
- **Docker Logs:**  
   ```bash
   docker logs container_name
   ```
- **Docker Inspect:**  
   ```bash
   docker inspect container_name
   ```
- **Network Traffic Monitoring:**  
   - Use **tcpdump** or **Wireshark** to monitor network traffic.

---

# 🔐 **Security Aspects of Docker**


### 🔐 **1. Signing Images**
- Use signed images to ensure authenticity and integrity.  
- Command to inspect signed images:
  ```bash
  docker trust inspect --pretty nginx
  ```

### 🔐 **2. Mutual TLS (MTLS)**
- Use **TLS certificates** to secure communication between Docker clients and servers.

**Configuration in `daemon.json`:**
```json
{
    "tls": true,
    "tlscacert": "/path/to/ca.pem",
    "tlscert": "/path/to/server-cert.pem",
    "tlskey": "/path/to/server-key.pem",
    "tlsverify": true
}
```

---

### 🛠️ **Generating a Certificate**

1. **Generate CA key and certificate.**  
2. **Generate server key and certificate.**  
3. **Sign the server certificate.**  
4. **Generate client certificate.**  
5. **Sign the client certificate.**
