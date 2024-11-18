# Network Devices and Hardware
---

## Topics to be Discussed

- **Routers**
- **Switches**
- **Firewalls**
- **Load Balancers**
- **Network Interface Cards (NICs)**

---

## Introduction to Routers

### What is a Router?

A **router** is a network device that plays a critical role in connecting different networks. Its main function is to direct, or "route," data packets between networks, ensuring that data can travel from its source to its intended destination. Routers operate primarily at the **Network Layer (Layer 3)** of the OSI model, where they make decisions about the best path for forwarding data based on information stored in routing tables.

### Why are Routers Important in DevOps?

- As a **DevOps engineer**, understanding how routers work is essential for managing and optimizing network infrastructure. Routers are fundamental to ensuring that data can be transferred securely and efficiently between different network segments or even across different geographical locations. Key responsibilities in DevOps related to routers include:
  - **Network Management**: Ensuring that networks are properly configured and optimized for performance.
  - **Security**: Implementing secure routing protocols to protect sensitive data.
  - **Performance Optimization**: Fine-tuning routing protocols to ensure minimal delays and optimal paths for data transmission.

### Key Components of a Router:

1. **Routing Table**:
   - The **routing table** is essentially the router’s internal "map" of the network. It stores information about all the networks the router is connected to, including the best paths for reaching each network. 
   - When a data packet arrives at the router, the router checks its destination address and consults the routing table to determine the best route. This decision is based on factors like **hop count** (the number of devices the data needs to pass through) and **network latency**.
   - By using this table, routers can select the most efficient path for forwarding the data, reducing delays and improving the overall performance of the network.

2. **Routing Protocol**:
   - **Routing protocols** are the rules or algorithms that routers use to communicate with each other and share information about the networks they know. These protocols allow routers to dynamically update their routing tables as the network changes (for example, when new devices are added or connections fail).
   - Some common routing protocols include **OSPF (Open Shortest Path First)** and **BGP (Border Gateway Protocol)**. These protocols help ensure that routers can quickly adapt to changes and continue to forward data along the best possible paths.
   - The **IP table** (Internet Protocol table) is an essential part of this process, as it allows the router to store and manipulate the routing information needed to make decisions about where to send packets.

---

## Switches

### What is a Switch?

A **network switch** is a device that connects multiple devices within a **Local Area Network (LAN)**, such as computers, printers, and servers. While a router directs traffic between different networks, a switch operates within a single network, ensuring that data is sent only to the specific device it is intended for. 

### Key Characteristics of Switches:

- **Targeted Data Transmission**: Unlike hubs, which send data to all devices connected to the network, switches are more efficient. They use the **MAC address** of each device to ensure that data is only sent to the device that needs it. This process reduces unnecessary traffic and improves overall network performance.
- **Data Link Layer Operations**: Switches operate at the **Data Link Layer (Layer 2)** of the OSI model. At this layer, they handle data in the form of **frames**, which include the MAC address of the destination device. By reading the MAC address, the switch knows exactly which device should receive the data.

### How Switches and Routers Differ:

- While **routers** are concerned with finding the best path to forward data between networks, **switches** focus on forwarding data within a single network by using the most direct path possible to reach the intended device.

---

## Firewalls

### What is a Firewall?

A **firewall** is a critical network security device that monitors and controls incoming and outgoing traffic based on predetermined security rules. Firewalls act as a barrier between trusted internal networks and untrusted external networks (such as the internet). They protect the network by filtering traffic and blocking unauthorized access while allowing legitimate communication.

### Types of Firewalls:

1. **Packet Filtering Firewall**:
   - A packet filtering firewall inspects each data packet passing through the network and filters them based on predefined rules, such as the source and destination IP addresses, the type of protocol used, or the port number. 
   - While effective for basic security, packet filtering firewalls have limitations. For instance, they cannot detect sophisticated attacks that involve reassembling seemingly harmless packets into a malicious sequence.
   - **Example**: Suppose three packets (p1, p2, p3) are individually harmless, but when they are rearranged in a specific sequence, they form a malicious attack. A basic packet filtering firewall may fail to detect this.

2. **Stateful Inspection Firewall**:
   - Unlike packet filtering firewalls, stateful inspection firewalls maintain a record of the state of active network connections. They monitor the entire TCP connection, not just individual packets.
   - These firewalls can detect and block unauthorized connection requests, even if they come in the form of what would otherwise appear to be legitimate packets.

3. **Application-Level Firewall (Proxy Firewall)**:
   - Application-level firewalls perform **Deep Packet Inspection (DPI)**, meaning they thoroughly examine the data contained in each packet, rather than just the headers. 
   - These firewalls operate at the **Application Layer (Layer 7)** and can inspect protocols like HTTP, SMTP, and FTP.
   - They use **IP Tables** to enforce security rules, with key components including:
     - **Chains**: Pathways for data packets, such as the Input chain (for incoming data) and the Output chain (for outgoing data).
     - **Rules**: Set instructions that determine how packets should be handled.
     - **Policies**: Default actions applied if no specific rule matches a packet.

### Important Firewall Commands:

- **View all current rules**: 
  ```bash
  sudo iptables -L
  ```
- **Allow incoming SSH traffic on port 22**: 
  ```bash
  sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
  ```
  - Here, `-A INPUT` adds a rule to the Input chain, `-p tcp` specifies the protocol, and `-j ACCEPT` tells the firewall to accept packets matching the rule.

---

## Load Balancers

### What is a Load Balancer?

A **load balancer** is a device or software that distributes incoming network traffic across multiple servers. This ensures that no single server becomes overwhelmed by too much traffic, which can degrade performance or lead to server crashes. Load balancers are used to maintain high availability and performance by balancing the workload among available servers.

### Key Features of Load Balancers:

- **High Availability**: Load balancers prevent system overloads by distributing requests evenly across multiple servers. In case one server fails, the load balancer automatically redirects traffic to the other functioning servers.
- **Health Checks**: Load balancers continuously monitor the health of servers and ensure that only operational servers receive traffic.
- **Traffic Distribution Algorithms**:
  1. **Round Robin**: Directs traffic sequentially to each server in turn.
  2. **Least Connections**: Directs traffic to the server with the fewest active connections.
  3. **IP Hash**: Directs traffic based on the client’s IP address, ensuring consistent connections to the same server for that client.

### Use Cases:

- **Web Servers**: Distribute incoming user requests to multiple web servers to handle large volumes of traffic efficiently.
- **Database Servers**: Balance database queries among multiple database servers to ensure smooth operation.
- **Application Servers**: Distribute application requests, ensuring that no single server handles too much load.

---

## Network Interface Card (NIC)

### What is a Network Interface Card?

A **Network Interface Card (NIC)** is a hardware component that allows a computer or device to connect to a network. NICs convert data into signals that can be transmitted over the network and ensure that the device can both send and receive data from other devices on the network.

### Types of NICs:

1. **Ethernet NIC**: 
   - Used for wired networks, connecting devices to the network using Ethernet cables. It enables fast and reliable communication over local networks.
   
2. **Wireless NIC**:
   - Used for wireless communication over Wi-Fi networks, allowing devices to connect to the network without physical cables.

![Network diagram](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/645/original/Screenshot_2024-09-30_145139.png?1727688122)


