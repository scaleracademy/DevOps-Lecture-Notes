

# Introduction to Computer Networks

## Topics to be discussed:

- **Computer Network and its Types**
- **Network Architecture**
- **How Networks Work**
- **Addressing in Networks**
- **Communication Types**
- **Network Transmission Types**
- **Network Topologies**
- **OSI Model**
- **How Data is Transferred Between Two Computers**

---

## Computer Network and Its Types
A **computer network** is a system that allows two or more computers or devices to communicate and share resources. This interconnection is essential in modern computing environments, enabling multiple tasks such as data exchange, centralized management, and resource sharing across different devices.

### Why Networks are Needed
1. **Communication**:  
   Networks allow computers to send and receive information across geographical distances, facilitating global connectivity.
   
2. **Resource Sharing**:  
   Through a network, resources such as printers, storage devices, and software applications can be shared between computers, minimizing duplication and optimizing usage.

3. **Centralized Management**:  
   Centralized management of resources and services (such as user permissions, files, and software updates) becomes efficient in a networked environment. This setup allows administrators to oversee operations from a single point.

### Types of Networks:
Networks can be classified based on their size and the geographical area they cover:

1. **PAN (Personal Area Network)**:  
   A **Personal Area Network** is the smallest type of network that connects devices within a very short range, usually a few meters. It is typically used to connect devices like smartphones, tablets, and Bluetooth headsets. For example, connecting a smartphone to a laptop via Bluetooth is an example of a PAN.

2. **LAN (Local Area Network)**:  
   A **Local Area Network** is a network that spans a small geographical area, like an office building, school, or home. Devices within a LAN can communicate and share resources like printers or file servers. A common example is the Wi-Fi network in your home or office.

3. **MAN (Metropolitan Area Network)**:  
   A **Metropolitan Area Network** covers a larger geographical area than a LAN, often a city or a large campus. Universities or large business districts often implement MANs to connect their facilities across various locations.

4. **WAN (Wide Area Network)**:  
   A **Wide Area Network** covers an even broader area than a MAN, such as a country or continent. WANs often connect multiple LANs or MANs, forming the backbone of the Internet. An example of a WAN is a telecommunications network connecting various cities.

---

## Network Architecture
Network architecture refers to the structural design that determines how computers and devices are connected and how they communicate with one another.

### Types of Network Architecture:
1. **Client-Server Architecture**:  
   In **Client-Server Architecture**, there is a central **server** that manages and provides resources, and multiple **clients** (computers or devices) that access these resources. The client sends requests to the server, and the server responds accordingly. This is a **centralized** architecture where the server plays a dominant role in managing data, security, and access control. Examples include web servers, file servers, and database servers.
   
   **Key Characteristics**:
   - Centralized control and management.
   - More secure and easier to manage, as resources are concentrated on the server.
   - Ideal for organizations that require strict control over data access.

2. **Peer-to-Peer (P2P) Architecture**:  
   In a **Peer-to-Peer (P2P)** network, all devices, known as **peers**, are considered equal and communicate directly with one another. Unlike the client-server model, there is no central server. Instead, every computer can act as both a client and a server. This model is **decentralized**, making it more scalable and fault-tolerant.

   **Key Characteristics**:
   - No central server; each device can share its resources.
   - More difficult to manage, as there is no centralized control.
   - Commonly used for file-sharing applications like BitTorrent.
   ![Peer-to-Peer Architecture](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/741/original/1.png)

---

## How Networks Work
Networks operate using **protocols**, which are sets of rules that determine how data is transmitted and received between devices. Protocols ensure that communication is standardized, reliable, and secure.

### Key Protocols:
- **HTTP (Hypertext Transfer Protocol)**:  
   - HTTP is the protocol used for **web communication**. It functions in a **client-server** model, where the client (usually a web browser) sends requests to a server, which responds with the requested information, such as a web page.
   - HTTP is a **stateless** protocol, meaning that after a request and response cycle is completed, the server does not retain any information about the session. If the user revisits the same page, a new request must be made.
   
- **HTTPS (Hypertext Transfer Protocol Secure)**:  
   - HTTPS is a secure version of HTTP. It encrypts the data exchanged between the client and server using a **certificate chain**, ensuring that the communication is private and protected from interception or tampering.

- **FTP (File Transfer Protocol)**:  
   - FTP is used to transfer files between computers over a network. It requires **authentication** (typically, a username and password) to ensure that only authorized users can transfer files.

- **SMTP (Simple Mail Transfer Protocol)**:  
   - SMTP is the protocol responsible for **email transmission**. When you send an email, SMTP transfers it to the recipient's email server. The server then delivers it to the recipient's inbox.

### Purpose of Protocols:
Protocols serve several critical functions:
- **Formatting**: Ensure that data is properly formatted for transmission.
- **Addressing**: Ensure that data is delivered to the correct recipient.
- **Transmission**: Facilitate the correct transmission and reception of data across networks.

---

## How is Addressing Done?
Addressing in networks is essential for identifying devices and ensuring that data is sent to the correct destination. Two key types of addresses are used in networks:

### Types of Addresses:
1. **MAC Address (Media Access Control)**:  
   - A **MAC Address** is a unique, hardware-based identifier assigned to the **Network Interface Card (NIC)** of every device. It is a **physical** address that never changes and is used at the **data link layer** of networking.
   - The MAC address consists of six pairs of **hexadecimal digits**, such as `00:1A:2B:3C:4D:5E`. It is used to ensure that data is sent to the correct hardware device on the network.
   
2. **IP Address (Internet Protocol)**:  
   - An **IP Address** is a logical address used at the **network layer** of communication. Unlike a MAC address, an IP address can change and is used to route data between networks.
   - IP addresses come in two versions:
     - **IPv4**: 32-bit addresses written in dotted decimal format (e.g., `192.168.1.1`).
     - **IPv6**: 128-bit addresses written in hexadecimal format, designed to support a vastly larger number of devices.
   - A device’s IP address can change over time, especially in networks using **dynamic addressing** (DHCP). However, its MAC address remains the same.

---

## Communication Types
Communication between devices can occur in different ways, depending on whether the data flow is one-directional or bidirectional.

### Types of Communication:
1. **Simplex Communication**:  
   - In **simplex communication**, data can only flow in **one direction**. The sender transmits data to the receiver, and the receiver does not send any data back.  
   - Example: A **keyboard** sending input to a computer. The computer does not send information back to the keyboard.

2. **Half-Duplex Communication**:  
   - **Half-duplex communication** allows data to flow in **both directions**, but not at the same time. Only one party can transmit data at a time, while the other listens. Once the first party finishes, the other can respond.
   - Example: **Walkie-talkies** are half-duplex devices where only one person can talk at a time.

3. **Full-Duplex Communication**:  
   - In **full-duplex communication**, data flows in **both directions simultaneously**. This is the most efficient form of communication, as both parties can send and receive data at the same time.
   - Example: **Phone calls** allow

 both people to speak and listen at the same time.

---

## Network Transmission Types
Network transmission defines how data is sent from one device to others in the network.

### Transmission Types:
1. **Unicast**:  
   In unicast transmission, data is sent from **one device to another specific device**. This is a one-to-one transmission where the sender and receiver are unique.  
   ![Unicast](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/742/original/2.png)

2. **Multicast**:  
   In multicast transmission, a device sends data to **multiple specific receivers**. The number of receivers is limited, and only those who subscribe to the multicast group receive the data.  
   ![Multicast](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/743/original/3.png)

3. **Broadcast**:  
   In broadcast transmission, a device sends data to **all devices on the network**. This is a one-to-many form of transmission, where all devices within the network receive the data, regardless of whether they requested it.  
   ![Broadcast](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/744/original/4.png)

---

## Network Topologies
Network topology refers to the **physical or logical arrangement** of devices in a network.

### Types of Network Topologies:
1. **Bus Topology**:  
   In a **bus topology**, all devices are connected to a **single communication line** (bus). Data sent by a device is broadcast to all other devices, but only the intended recipient accepts and processes it.  
   ![Bus Topology](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/745/original/5.png)

2. **Ring Topology**:  
   In a **ring topology**, devices are arranged in a **circular formation**, with each device connected to two neighboring devices. Data travels in one direction around the ring, passing through each device until it reaches its destination. A failure in any one device can disrupt the entire network.  
   ![Ring Topology](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/746/original/6.png)

3. **Star Topology**:  
   In a **star topology**, all devices are connected to a **central hub or switch**. The hub acts as a relay point for transmitting data between devices. If a device fails, it does not affect the rest of the network, but if the hub fails, the entire network is down.  
   ![Star Topology](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/747/original/7.png)

4. **Mesh Topology**:  
   In a **mesh topology**, devices are interconnected with **multiple paths** between nodes, providing high redundancy and fault tolerance. There are two types:
   - **Full Mesh**: Every device is connected to every other device.
   - **Partial Mesh**: Only some devices are fully interconnected, while others are connected to fewer devices.  
   ![Mesh Topology](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/749/original/8.png)

---

## OSI Model

The **Open Systems Interconnection (OSI) Model** is a conceptual framework that standardizes the communication functions of a telecommunication or computing system without regard to its underlying internal structure. The OSI model divides the communication process into **seven layers**, each with a specific function.

### Layers in OSI Model:
1. **Physical Layer**:  
   The **physical layer** deals with the transmission of raw data bits over a physical medium, such as cables or radio waves. It is analogous to roads in a transportation system, without which no communication could occur.

2. **Data Link Layer**:  
   The **data link layer** ensures that data transferred between two devices is error-free. It manages MAC addressing and controls how devices access the network medium.

3. **Network Layer**:  
   The **network layer** is responsible for routing data from the source to the destination by determining the **best path** through a network. It adds an IP address to data packets for identification.

4. **Transport Layer**:  
   The **transport layer** ensures reliable data transfer by managing data segmentation, flow control, and error handling. **TCP (Transmission Control Protocol)** and **UDP (User Datagram Protocol)** operate at this layer.

5. **Session Layer**:  
   The **session layer** manages and controls the dialogues (sessions) between computers. It establishes, maintains, and terminates sessions as needed.

6. **Presentation Layer**:  
   The **presentation layer** formats or translates data for the application layer. This layer handles **encryption, compression**, and **data translation**.

7. **Application Layer**:  
   The **application layer** provides network services directly to the end-user applications, such as email, file transfer, and web browsing. This is where users interact with the network via software like browsers and email clients.  
   ![OSI Model](https://d2beiqkhq929f0.cloudfront.net/public_assets/assets/000/091/750/original/9.png)

---

## How is Data Transferred Between Two Computers?

When data is sent from one computer to another, the process involves multiple steps, known as **encapsulation** and **decapsulation**. These processes take place as data moves down and up the layers of the OSI model.

### Encapsulation Process:
1. **Application Layer**:  
   - The data is created by the user and processed by the application, such as a web browser or email client.
   
2. **Presentation Layer**:  
   - The data is formatted and, if necessary, **encrypted** or **compressed**.

3. **Session Layer**:  
   - The session layer adds session management information to ensure that the communication between the two devices is properly established and maintained.

4. **Transport Layer**:  
   - The data is divided into smaller segments, and a **TCP** or **UDP** header is added, depending on the communication protocol. For example:
     - **TCP** is used for reliable communication, such as file transfers or email.
     - **UDP** is used for faster, less reliable communication, such as video streaming.

5. **Network Layer**:  
   - The **IP address** of the destination is added, creating a data packet that can be routed through different networks.

6. **Data Link Layer**:  
   - The **MAC address** of the destination is added, converting the packet into a **frame**.

7. **Physical Layer**:  
   - The frame is converted into **bits** (1s and 0s) and transmitted over the physical medium, such as an Ethernet cable or wireless signal.

### Decapsulation Process:
Once the data reaches the destination computer, the reverse process occurs, starting from the **physical layer** and working upwards:

1. **Physical Layer**:  
   - The bits are received and reassembled into frames.

2. **Data Link Layer**:  
   - The **MAC address** is checked, and the MAC header is removed.

3. **Network Layer**:  
   - The **IP address** is verified, and the IP header is removed.

4. **Transport Layer**:  
   - The **TCP/UDP** header is inspected, and data is reassembled into segments.

5. **Session Layer**:  
   - The session is managed or terminated depending on the data received.

6. **Presentation Layer**:  
    - The data is **decrypted** or **decompressed** ,if necessary.
7. **Application Layer**:  
   - The data is presented to the user in its final form, such as a web page or email message.

This entire process ensures that data is transmitted accurately and reliably across a network.
